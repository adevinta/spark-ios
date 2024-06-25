#/bin/sh

# find . -type d -empty | xargs git rm

pp () {
   IFS='/' read -r -a array <<< "$1"
   folder=${array[0]}
   file=$(IFS='/'; echo "${array[*]:1}")
   if [ -d "$1" ]; then
      if [ "${array[1]}" = "Sources" ] || [ "${array[1]}" = "Tests" ]; then
         :
      else
         for f in ${1}/*; do
            pp "$f"
         done
      fi
   else
     fp=`echo "${file%/*}/"`
     if [ -z "${file##*+ExtensionTests.swift}" ]; then
        if ! [ -d "${folder}/Sources/Testing/${fp}" ]; then
           mkdir -p ${folder}/Sources/Testing/${fp}
        fi
        git add ${folder}/Sources/Testing/${fp}
        git mv ${folder}/${file} ${folder}/Sources/Testing/${file}
     elif [ -z "${file##*[M|m]ock*.swift}" ]; then
        if ! [ -d "${folder}/Sources/Testing/${fp}" ]; then
           mkdir -p ${folder}/Sources/Testing/${fp}
        fi
        git add ${folder}/Sources/Testing/${fp}
        git mv ${folder}/${file} ${folder}/Sources/Testing/${file}
     elif [ -z "${file##*SnapshotTests.swift}" ]; then
        if ! [ -d "${folder}/Tests/SnapshotTests/${fp}" ]; then
           mkdir -p ${folder}/Tests/SnapshotTests/${fp}
        fi
        git add ${folder}/Tests/SnapshotTests/${fp}
        git mv ${folder}/${file} ${folder}/Tests/SnapshotTests/${file}
     elif [ -z "${file##*Tests.swift}" ]; then
        if ! [ -d "${folder}/Tests/UnitTests/${fp}" ]; then
           mkdir -p ${folder}/Tests/UnitTests/${fp}
        fi
        git add ${folder}/Tests/UnitTests/${fp}
        git mv ${folder}/${file} ${folder}/Tests/UnitTests/${file}
     else
        if ! [ -d "${folder}/Sources/Core/${fp}" ]; then
           mkdir -p ${folder}/Sources/Core/${fp}
        fi
        git add ${folder}/Sources/Core/${fp}
        git mv ${folder}/${file} ${folder}/Sources/Core/${file}
     fi
   fi
}

cd ./core/Sources/Components/

for component in *; do
  for f in ${component}/*; do
     pp "$f"
  done
done

