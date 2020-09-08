#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "broadinstitute/gatk:4.1.3.0"
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.RefFasta) ]


inputs:
  # REQUIRED ARGS

  RefFasta:
    type: File
    inputBinding:
      prefix: "-R"

  Output:
    type: string
    default: "human_g1k_v37.dict"
    inputBinding:
      prefix: "-O"
      valueFrom: "human_g1k_v37.dict"


baseCommand: ["/gatk/gatk"]

arguments:
  - valueFrom: "CreateSequenceDictionary"
    position: -1

outputs:
#  fastaDict:
#    type: File
#    outputBinding:
#      glob: $(inputs.RefFasta.basename)
#      glob: hg19.fa.dict
#    secondaryFiles:
#      - .fai
#      - .dict
   fastaDict:
    type: File
    outputBinding:
      glob: "*.fasta"
    secondaryFiles:
      - ^.dict
      - .fai
