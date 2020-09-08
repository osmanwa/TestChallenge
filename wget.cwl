#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget]

#requirements:
#  - class: InlineJavascriptRequirement

inputs:
  in_url:
    type: string
    default: "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz"
    inputBinding:
      position: 1

outputs:
  out_wget:
    type: File
    outputBinding:
      glob: ['*']
