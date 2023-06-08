$filename=".\downsite.log"
$search="Object"

#gets the line number of string $search
$linenumber= Get-Content $filename | select-string $search
$linenumber.LineNumber

#removes all lines before line number -1 (to include headers)
$temp_output = Get-Content $filename | Select-Object -Skip ($linenumber.LineNumber-1) #| Out-File sites_list.log



#gets the line number of string "Log close:" to clear it from bottom of output
$bottom_line = ($temp_output | select-string "Log close:").LineNumber - 3

# reads N number of file and write it to output
$temp_output | select -First $bottom_line | Out-File sites_list.txt
