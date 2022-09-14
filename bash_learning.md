[A gread online bash tutorial for begginners](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)

- instructions for command: `man COMMAND`

- basic commands: `date`, `cal`, `pwd`, `ls`  
    `cat` display the content of any given file.  
    
- shebang:  
    `#!/bin/bash`  
    
- file permission: 
`chmod +x FILENAME`  

- variable: 
`greeting="Welcome"`  

- command substitution:  

```shell  
user=$(whoami)  
day=$(date +%A)      
```  
    the output of the `whoami` and `date +%A` commands will be directly assigned to the `user` and `day` variables
    
-  substituting variable names prefixed by `$` sign with their relevant values:   
    `echo "$greeting back $user! Today is $day, which is the best day of the entire week!"` 
    
- parameter expansion `${parameter}`   

```shell  
user=$(whoami)  
input=/home/$user  
output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz
```  

- internal variable:  
`$BASH_VERSION`

- input, output and error redirections:   
    `>` redirect standard outputs to a file  
    `2>` redirect standard errors to a file  
    `&>` redirect both standard outputs and standard errors to a file  
    
```shell
ls task.sh foobar > stdout.txt
ls task.sh foobar 2> stderr.txt
ls task.sh foobar &> stdoutandstderr.txt
cat stdout.txt
cat stderr.txt
cat stdoutandstderr.txt
```
    
- functions:      
```shell
#!/bin/bash
function user_details {
    # do something
}
```  
    
- function parameters:      

```shell
function total_files {
    find $1 -type f | wc -l
}

total_files $input # `$input` is the argument pointed to `$1`
```  

- numeric and string comparisions  

| Description                | Numeric Comparision | String Comparision |
| -------------------------- | ------------------- | ------------------ |
| less than                  | -lt                 | <                  |
| greater than               | -gt                 | >|
| equal                      | -eq | = |
| not equal                  | -ne | != |
| less or equal              | -le | N/A |
| greater or equal           | -ge | N/A |
| Shell comparision example: | `[100 -eq 50]`; `echo $?` |`["GNU"="UNIX"]`; `echo $?` |
    
- conditional statements:  

```shell
if [conditional statements]; then
    # do something
else
    # do something
fi
```
    
- poistional parameters:  

`$1`, `$2`, `$N`  positional parameters exactly in order as they are supplied during the script's execution  
`$#` the total number of supplied arguments  
`$*` all the arguments  
`output=/Users/$(whoami)/programming/"$2"/"$1"_$(date +%Y-%m-%d_%H%M%S).tar.gz`: use `"$1"`` when it is in the variables  

`-z` whether positional parameter `$1` contains any values  
`-d` returns true if the directory exists  
`!` acts as a negator  
`exit 1` cause script execution termination. `exit` value `1` as opposed to `0` meaning that the script exited with an error.
    
- bash loops  
    1. for loop:  
    ```shell
    for i in list; do
        # do something
    done
    ```
    2. while loop:  
    ```shell
    while [ conditional statement ]; do
        # do something
    done
    ```  
    3. until loop:  
    ```shell
    until [ conditional statement ]; do
        # do something
    done
    ```
 - arthmetrics
 
 ```shell
 echo $((12 + 5))  
 expr 12 + 5  
 let a=2+2  
 echo 'scale=3;8.5/2.3' | bc
```

- named parameters:

```shell    
#!/bin/bash  
while getopts n:a:g: flag; do  
  case "${flag}" in
    n) name=${OPTARG};;  
    a) age=${OPTARG};;
    g) gender=${OPTARG};;  
  esac   
done 

echo "Name: $name";  
echo "Age: $age";  
echo "Gender:$gender";  
```
> ./named_parameter.sh -n Angela -a 27 -g female
> Name: Angela  
> Age: 27  
> Gender:female  

- multiple values in one options: 

```shell
#!/bin/bash
while getopts "i:o:" opt; do
  case $opt in
    i) input+=($OPTARG);;
    o) output=($OPTARG);;
  esac
done
shift $((OPTIND -1))

for directory in ${input[@]}; do  
    echo "$directory"  
    echo "$output"
done
```    

> $ ./backup_input_output.sh -i learn_git -i learn_git_clone -o backup  
>  learn_git  
>  backup   
>  learn_git_clone  
>  backup    

- array:  
    1. define an array:  
    `ArrayName=("element 1" "element 2" "element 3")`
    2. retrive an element of an array:  
    `echo ${ArrayName[0]}`  
    3. length of an array:  
    `echo ${#ArrayName[@]}`
    4. iterate array:
    
```shell
for directory in 
    echo "- $directory"
    echo $output
done
```
