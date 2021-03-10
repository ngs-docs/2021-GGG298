rule run_all_of_me:
    input: "all.cmp.matrix.png"
    

rule download_genomes:
    output: "1.fa.gz", "2.fa.gz", "3.fa.gz", "4.fa.gz", "5.fa.gz"
    shell: """
       wget https://osf.io/t5bu6/download -O 1.fa.gz
       wget https://osf.io/ztqx3/download -O 2.fa.gz
       wget https://osf.io/w4ber/download -O 3.fa.gz
       wget https://osf.io/dnyzp/download -O 4.fa.gz
       wget https://osf.io/ajvqk/download -O 5.fa.gz
    """

rule sketch_genomes:
    input:
        "{name}.fa.gz"
    output:
        "{name}.fa.gz.sig"
    shell: """
        sourmash compute -k 31 {input} -o {output}
    """

rule compare_genomes:
    input:
        expand("{n}.fa.gz.sig", n=[1, 2, 3, 4, 5])
    output:
        cmp = "all.cmp",
        labels = "all.cmp.labels.txt"
    shell: """
        sourmash compare {input} -o {output.cmp}
    """

rule plot_genomes:
    input:
        cmp = "all.cmp",
        labels = "all.cmp.labels.txt"
    output:
        "all.cmp.matrix.png",
        "all.cmp.hist.png",
        "all.cmp.dendro.png",
    shell: """
        sourmash plot {input.cmp}
    """
