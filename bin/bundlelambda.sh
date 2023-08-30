# bundlelambda.sh
#!/usr/bin/env bash

OUTPUT_ZIP="flask-app.zip"
ARCHIVE_TMP="/tmp/lambda-bundle-tmp.zip"

addToZip() {
    local exclude_packages="setuptools pip easy_install"
    zip -r9 s"$ARCHIVE_TMP" \
        --exclude ./*.pyc \
        --exclude "$exclude_packages" \
        -- "${@}"
}
addDependencies() {
    local packages_dir=()
    packages_dir+=($(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"))
    env_packages=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib(plat_specific=1))")
    if [[ "$env_packages" != "${packages_dir[0]}" ]]; then
        packages_dir+=($env_packages)
    fi
    for (( i=0; i<${#packages_dir[@]}; i++ )); do
        [[ -d "${packages_dir[$i]}" ]] && cd "${packages_dir[$i]}" && addToZip -- *
    done
}

#rm "$ARCHIVE_TMP" "$OUTPUT_ZIP"
addDependencies
addToZip app ./*.py
mv "$ARCHIVE_TMP" "$OUTPUT_ZIP"