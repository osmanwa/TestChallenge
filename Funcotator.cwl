#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "broadinstitute/gatk:4.1.1.0"
  InlineJavascriptRequirement: {}


inputs:
  InputVCF:
    type: File
    inputBinding:
      prefix: "--variant"

  DataSources:
    type: Directory
    inputBinding:
      prefix: "--data-sources-path"

  OutputFormat:
    type:
     - type: enum
       symbols:
        - MAF
        - VCF
        - SEG
    inputBinding:
      prefix: "--output-file-format"

  Reference:
    type: File
    inputBinding:
      prefix: "--reference"

  RefVersion:
    type: string
    inputBinding:
      prefix: "--ref-version"

  ForceRef:
    type: boolean
    default: true
    inputBinding:
      prefix: "--force-b37-to-hg19-reference-contig-conversion"


  Output:
    type: string
    inputBinding:
      prefix: "--output"

baseCommand: ["/gatk/gatk"]

arguments:
  - valueFrom: "Funcotator"
    position: -1

outputs:
  annotated_variants:
    type: File[]
    outputBinding:
      glob: "variants.funcotated"


