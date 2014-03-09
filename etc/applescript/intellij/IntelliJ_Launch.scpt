on open location this_URL
    do shell script quoted form of (POSIX path of (path to home folder) & "/bin/_intellij/launch.rb") & " " & quoted form of this_URL
end open location
