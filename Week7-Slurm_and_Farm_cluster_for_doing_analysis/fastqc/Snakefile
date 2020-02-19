rule all:
    input:
        "ERR458493_fastqc.html",
        "ERR458493_fastqc.zip"

rule download_data:
    output:
        "ERR458493.fastq.gz"
    shell:
        "curl -L https://osf.io/5daup/download -o ERR458493.fastq.gz"

rule make_fastqc:
    input:
        "ERR458493.fastq.gz"
    output:
        "ERR458493_fastqc.html",
        "ERR458493_fastqc.zip"  
    conda: "env-fastqc.yml"
    shell:
        "fastqc ERR458493.fastq.gz"
