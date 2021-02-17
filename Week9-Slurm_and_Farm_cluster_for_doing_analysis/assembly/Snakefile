rule all:
    input:
        "rel606.annot",
        "rel606.quast"

# copy in the relevant data
rule link_data:
    input:
        "/home/ctbrown/data/ggg201b/{filename}.fastq.gz"
    output:
        "{filename,[A-Za-z0-9_]+}.fastq.gz"
    shell:
        "ln -fs {input} {output}"

# run the assembler!
rule assemble_data:
    input:
        r1 = "SRR2584857_1.fastq.gz",
        r2 = "SRR2584857_2.fastq.gz"
    output:
        directory("rel606.megahit.out")
    threads: 8
    params:
        ram="5e9",
    shell:
        """megahit -1 {input.r1} -2 {input.r2} -o {output} -f -t {threads} \
               -m {params.ram}"""

# copy the final.contigs.fa file out of the megahit assembly directory
rule copy_genome_contigs:
    input:
        "rel606.megahit.out"
    output:
        "rel606.contigs.fa"
    shell:
        "cp {input}/final.contigs.fa {output}"

# annotate an assembly using prokka; *.contigs.fa -> *.prokka
rule annotate_contigs:
    input:
        "{prefix}.contigs.fa"
    output:
        directory("{prefix}.annot")
    threads: 8
    shell:
        # note: a bug in prokka+megahit means we have to force success.
        # that's what "|| :" does.
        "prokka --outdir {output} --prefix {wildcards.prefix} {input} --cpus {threads} || :"

# evaluate an assembly using quast; *.contigs.fa => *.quast
rule quast_eval:
    input:
        "{prefix}.contigs.fa"
    conda: "env-quast.yml"      # note, you need to run this with --use-conda!
    output:
        directory("{prefix}.quast")
    shell: "quast {input} -o {output}"

### these rules produce assemblies from subsampled read sets
### they are part of HW #2

rule subsample_reads:
    input: "{name}.fastq.gz"
    output: "{name}.{num_reads,[0-9]+}.fastq.gz"
    shell:
        "(gunzip -c {input} || true) | head -{wildcards.num_reads} | gzip > {output}"

rule assemble_data_subsample:
    input:
        r1 = "SRR2584857_1.{num_reads}.fastq.gz",
        r2 = "SRR2584857_2.{num_reads}.fastq.gz"
    output:
        directory("rel606.{num_reads,[0-9]+}.megahit.out")
    threads: 8
    params:
        ram="5e9",
    shell:
        """megahit -1 {input.r1} -2 {input.r2} -o {output} -f -t {threads} \
               -m {params.ram}"""

rule copy_genome_contigs_subsample:
    input:
        "rel606.{num_reads}.megahit.out"
    output:
        "rel606.{num_reads,[0-9]+}.contigs.fa"
    shell:
        "cp {input}/final.contigs.fa {output}"
