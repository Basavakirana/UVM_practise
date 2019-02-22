#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////#
#/////////////////////////Copyright © 2022 Vivartan Technologies., All rights reserved////////////////////////////#
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////#
#//                                                                                                              //#
#//All works published under Zilla_Gen_0 by Vivartan Technologies is copyrighted by the Association and ownership//# 
#//of all right, title and interest in and to the works remains with Vivartan Technologies. No works or documents//#
#//published under Zilla_Gen_0 by Vivartan Technologies may be reproduced,transmitted or copied without the expre//#
#//-ss written permission of Vivartan Technologies will be considered as a violations of Copyright Act and it may//#
#//lead to legal action.                                                                                         //#
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////#
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#
#* File Name : run11.py
#
#* Purpose :simulation and regression
#
#* Creation Date : 11-12-2024
#
#* Last Modified : Fri 27 Dec 2024 07:41:38 AM IST
#
#* Created By : Prathik  
#
#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#.

import subprocess
import sys
import argparse
import random
import os
from datetime import datetime
#xrun -f filelist.f -covsave /path/to/save/coverage/data
#
def read_test_case_from_file(test_case_file):
    """
    reads test case from a given file.

    :param test_case_file: path to file containing test case names.
    :return list of test cases.
    """
    try:
        with open(test_case_file, "r") as file:
            test_cases = [line.strip() for line in file if line.strip()]
        return test_cases
    except FileNotFoundError:
        print(f'Error: test case file {test_case_file} not found.')
        sys.exit(1)

def run_xrun(filelist, test_case, seed=None,verbosity = "UVM_MEDIUM", enable_coverage=False,additional_args=None, cov_dir="cov_work"):
    """
    Executes the xrun tool with specified arguments.

    :param filelist: Path to the filelist.
    :param test_case: Name of the UVM test case.
    :param seed: Seed value for the simulation. If None, a random seed is used.
    :param additional_args: List of additional arguments to pass to xrun.
    :param enable_coverage: Boolean indicating whether to enable coverage collection.
    """
    # Determine seed value
    seed_value = seed if seed is not None else random.randint(1, 99999)

    # Generate timestamp for log directory and file naming
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_dir = f"logs/{timestamp}_{test_case}_{seed_value}"
    os.makedirs(log_dir, exist_ok=True)
    
    # Define log file name
    log_file = os.path.join(log_dir,f"{test_case}_{seed}.log")

    # Specify coverage file path
    cov_file = os.path.join(cov_dir,f"test_seed_{seed_value}.ucd")

    # Base xrun command
    command = [
        "xrun", "-f", filelist, "-uvmhome", "CDNS-1.1d",
        f'+UVM_TESTNAME={test_case}', f'-seed {seed_value}', "-debug", "-access", "+rwc", f" -covdut apb_master -covworkdir {cov_dir} ", #-covtest {test_case}" ,
        "-logfile", f"{log_dir}/{test_case}_{seed}_{timestamp}.log", f'+UVM_VERBOSITY={verbosity}'
    ]

    # Add coverage flag if enabled
    if enable_coverage:
        #command.append("-coverage")
        #command.append("all")
        command.extend(["-coverage", "all", "-covoverwrite"])

    # Add additional arguments if provided
    if additional_args:
        command.extend(additional_args)

    print(f"Executing command: {' '.join(command)}")

    try:
        # Run the command and capture the output
        #with open(log_file, "w") as log:
        result = subprocess.run(command, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        print("Output:")
        #print(result.stdout)
        #log.write(result.stdout)

        uvm_fatal_count = 0
        uvm_error_count = 0
        uvm_info_count = 0
        for line in result.stdout.splitlines():
            if "UVM_FATAL" in line and "count" in line:
                uvm_fatal_count = int(line.split()[-1])
                return false
            if "UVM_ERROR" in line and "count" in line:
                uvm_error_count = int(line.split()[-1])
                return false
            if "UVM_INFO" in line and "count" in line:
                uvm_info_count = int(line.split()[-1])

        print(f"UVM FATAL COUNT == {uvm_fatal_count}")
        print(f"UVM ERROR COUNT == {uvm_error_count}")
        print(f"UVM INFO COUNT == {uvm_info_count}")
        
        if uvm_fatal_count:
            return False
        if uvm_error_count:
            return False
        if uvm_info_count:
            return True
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error during xrun aexecution: {e.stderr}")
        #print(result.stdout)
        sys.exit(1)
        return False

def run_regression(filelist, test_cases, seed=None,verbosity = "UVM_MEDIUM", enable_coverage=False, count= 100, additional_args=None, cov_dir="cov_work/scope"):
    all_test_passed = True

    for i in range(1, int(count)):
        for test_case in test_cases:
            print(f"Running test case:{test_case} [rgesn count: {int(count)}")
            test_passed = run_xrun(filelist=args.filelist,
                test_case=test_case,
                seed=args.seed,
                verbosity=args.verbosity,
                enable_coverage=args.coverage,
                additional_args=args.additional_args,
                    )
            if not test_passed:
                print(f"Test case {test_case} failed")
                all_test_passed = False
            else:
                print(f"Test case {test_case} passed")
        print(f" test case no {i+1} starting ")

    if all_test_passed:
        print("regression completed successfully, all test cases passed")
    else:
        print("Regression completed with failure, some test cases failed")


if __name__ == "__main__":
    # Argument parser setup
    parser = argparse.ArgumentParser(description="Run the xrun tool with specified arguments.")
    parser.add_argument("filelist", help="Path to the filelist.")
    parser.add_argument("--test_cases", nargs="+", help="Names of the UVM test cases to run.")
    parser.add_argument("--test_case_file", help="Path to files with the test cases names.")
    parser.add_argument("--regression", action="store_false", help="this will add regression")
    parser.add_argument("--rgrsn_count", type=int, help="iterations for regression, [default value=100] ")
    parser.add_argument("--seed", type=int, help="Seed value for the simulation. If not provided, a random seed is used.")
    parser.add_argument("--verbosity", default="UVM_MEDIUM", help="verbosity level for the simulation defaults to UVM_MEDIUM.")
    parser.add_argument("--coverage", action="store_true", help="Enable coverage collection.")
    parser.add_argument("--additional_args", nargs="*", default=[], help="Additional arguments to pass to xrun.")

    # Parse arguments
    args = parser.parse_args()

    # Run each test case
    if args.test_cases:
        for test_case in args.test_cases:
            print(f"Running test case: {test_case}")
            run_xrun(
                filelist=args.filelist,
                test_case=test_case,
                seed=args.seed,
                verbosity=args.verbosity,
                enable_coverage=args.coverage,
                additional_args=args.additional_args
                    )
    elif args.test_case_file:
        test_cases_f = read_test_case_from_file(args.test_case_file)
        run_regression(
                filelist=args.filelist,
                test_cases=test_cases_f,
                seed=args.seed,
                verbosity=args.verbosity,
                enable_coverage=args.coverage,
                count = args.rgrsn_count,
                additional_args=args.additional_args
                )
    else:
        print("Error: you must provide test case either as arguments or in a file.")



