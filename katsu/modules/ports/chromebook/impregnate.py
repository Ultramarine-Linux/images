#!/usr/bin/env python3

import argparse
import os

from gpt_image.disk import Disk
from gpt_image.partition import Partition, PartitionType

parser = argparse.ArgumentParser(
    description="Impregnate an ISO with submarine, outputting a GPT image"
)
parser.add_argument("kpart", help="Path to the kpart file")
parser.add_argument("iso", help="Path to the ISO file")
parser.add_argument("out", help="Path to the output GPT image")

args = parser.parse_args()

iso_size = os.path.getsize(args.iso)
kpart_size = os.path.getsize(args.kpart)
total_size = iso_size + kpart_size + 3 * 1024**2

disk = Disk(args.out)
disk.create(total_size)

kpart_part = Partition(
    "kpart",
    kpart_size,
    "fe3a2a5d-4f32-41a7-b725-accc3285a309",
    partition_attributes=0x011F000000000000,
)
disk.table.partitions.add(kpart_part)

iso_part = Partition("iso", iso_size, PartitionType.BASIC_DATA_PARTITION.value)
disk.table.partitions.add(iso_part)

disk.commit()

with open(args.kpart, "rb") as file:
    offset = 0
    while chunk := file.read(128 * 1024):
        kpart_part.write_data(disk, chunk, offset)
        offset += len(chunk)

with open(args.iso, "rb") as file:
    offset = 0
    while chunk := file.read(128 * 1024):
        iso_part.write_data(disk, chunk, offset)
        offset += len(chunk)
