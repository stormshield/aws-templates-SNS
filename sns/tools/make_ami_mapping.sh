#!/bin/sh


echo "  SNSRegionMap:"
for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text)
do
  echo -n "    ${region}:\n      HVM64: $(aws ec2 describe-images --filters Name=name,Values='STORMSHIELD Cloud UTM 4.2.2 EVA*' --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' --output text --region $region)\n"
done



echo "  UbuntuRegionMap:"
for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text)
do
  echo -n "    ${region}:\n      HVM64: $(aws ec2 describe-images --filters Name=name,Values='ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129' --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' --output text --region $region)\n"
done

