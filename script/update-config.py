#!/usr/bin/python3

import argparse
import configparser
import os


def parse_config(config_file, access):
    config = configparser.ConfigParser()
    config.read(config_file)
    if access not in config:
        print(f"Error: '{access}' not found in the config file.")
        return None, None, None, None
    if 'profile_name' not in config[access]:
        print(f"Error: 'profile_name' not found in the config file.")
        return None, None, None, None
    if 'aws_account_id' not in config[access]:
        print(f"Error: 'aws_account_id' not found in the config file.")
        return None, None, None, None
    if 'region' not in config[access]:
        print(f"Error: 'region' not found in the config file.")
        return None, None, None, None
    if 'role_name' not in config[access]:
        print(f"Error: 'role_name' not found in the config file.")
        return None, None, None, None
    if 'source_profile' not in config[access]:
        print(f"Error: 'source_profile' not found in the config file.")
        return None, None, None, None

    profile_name = config[access]["profile_name"]
    role_name = config[access]["role_name"]
    account_id = config[access]["aws_account_id"]
    region = config[access]["region"]
    source_profile = config[access]["source_profile"]

    return profile_name, role_name, account_id, region, source_profile


def update_aws_config(config_file, profile_name, role_name, account_id, region, source_profile):
    config = configparser.ConfigParser()
    config.read(config_file)

    arn = f"arn:aws:iam::{account_id}:role/{role_name}"

    if 'profile ' + profile_name not in config:
        config['profile ' + profile_name] = {}
    config['profile ' + profile_name]['region'] = region
    config['profile ' + profile_name]['role_arn'] = arn
    config['profile ' + profile_name]['source_profile'] = source_profile

    with open(config_file, 'w') as configfile:
        config.write(configfile)


def main():
    aws_config_path = os.path.expanduser("~/.aws/config")
    parser = argparse.ArgumentParser(
        description="Update AWS config file with a new profile section including the role ARN.")
    parser.add_argument("-c", "--config_file", default="profile.ini", help="Path to the AWS config file")
    parser.add_argument("-a", "--access", help="AWS CLI access(admin or read)")
    args = parser.parse_args()

    config_file = args.config_file
    access = args.access

    profile_name, role_name, account_id, region, source_profile = parse_config(config_file, access)

    if profile_name and role_name and account_id and region:
        update_aws_config(aws_config_path, profile_name, role_name, account_id, region, source_profile)
        print(f"Profile '{profile_name}' updated in '{aws_config_path}' with role ARN.")
    else:
        print("Error: Unable to extract necessary information from the config file.")


if __name__ == "__main__":
    main()
