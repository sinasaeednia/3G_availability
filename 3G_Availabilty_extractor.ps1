$filename="downsite.log"
$search="Object"
$output_file="site_list.txt"


#gets the line number of string $search
$linenumber= Get-Content $filename | select-string $search
$linenumber.LineNumber

#removes all lines before line number -1 (to include headers)
$temp_output = Get-Content $filename | Select-Object -Skip ($linenumber.LineNumber-1) #| Out-File sites_list.log



#gets the line number of string "Log close:" to clear it from bottom of output
$bottom_line = ($temp_output | select-string "Log close:").LineNumber - 3

# reads N number of file and write it to output
$temp_output = $temp_output | select -First $bottom_line # | Out-File $output_file

# Counting number of hours in output (to compare withnumber of 100
$count_of_hours = (($temp_output | Select -First 1).Split(':')).count-1 


# compares number of 100 (using replace) with $count_of_hours and remove them          $count_of_100 = (Get-Content $output_file | Select-Object -Skip 1 | Select -First 1).replace('100','@').Split('@').count-1 
 $result = switch ($temp_output) {
        { $_.replace('100','@').Split('@').count-1  -ne $count_of_hours } { $_ }  # only output lines that are less or equal to 4000 characters
        # default { $skipped++ }         # count the lines that were longer than 4000 characters
    }

$result | Out-File $output_file


<#  Release notes

V01:
    Filters lines with all availabilities set to 100 
V00:
    Extracts table like information from .log output file
#>