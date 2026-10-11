# Installation may adjust binary RPATHs; record hashes after those changes.
foreach(i RANGE 0 1)
    list(GET destinations ${i} destination)
    file(SHA256 "${destination}" installed_hash)
    file(APPEND "${backup}/manifest.cmake" "set(installed_hash_${i} ${installed_hash})\n")
endforeach()
