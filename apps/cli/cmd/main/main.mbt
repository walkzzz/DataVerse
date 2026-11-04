///|
/// # DataVerse CLI — 生产级命令行工具 / Production CLI
///
/// 命令分发架构 + 功能展示。当 MoonBit 支持 argv 时可扩展为真正的 CLI。
///
/// 支持命令：
///   version / help / stats / mean / std / sum / sort / sqrt / factorial / gcd / isprime / fibonacci

///|
/// 命令分发器（数值参数）/ Command dispatcher with numeric args.
pub fn run_command(cmd : String, nums : Array[Double]) -> String {
  match cmd {
    "version" => cmd_version()
    "help" => cmd_help()
    "stats" => cmd_stats()
    "mean" => cmd_mean(nums)
    "std" => cmd_std(nums)
    "sum" => cmd_sum(nums)
    "sort" => cmd_sort(nums)
    "sqrt" => cmd_sqrt(nums)
    _ => "Unknown command: " + cmd + "\n\n" + cmd_help()
  }
}

///|
/// 整数命令分发器 / Integer command dispatcher.
pub fn run_int_command(cmd : String, args : Array[Int]) -> String {
  match cmd {
    "factorial" => cmd_factorial(args)
    "gcd" => cmd_gcd(args)
    "isprime" => cmd_isprime(args)
    "fibonacci" => cmd_fibonacci(args)
    _ => "Unknown command: " + cmd
  }
}

///|
fn main {
  println("DataVerse CLI v0.1.0-dev")
  println("========================")
  println("")
  println(cmd_version())
  println("---")
  println(cmd_stats())
  println("---")
  println(run_command("mean", [1.0, 2.0, 3.0, 4.0, 5.0]))
  println("---")
  println(run_command("std", [1.0, 2.0, 3.0, 4.0, 5.0]))
  println("---")
  println(run_command("sum", [1.0, 2.0, 3.0, 4.0, 5.0]))
  println("---")
  println(run_command("sort", [5.0, 3.0, 1.0, 4.0, 2.0]))
  println("---")
  println(run_command("sqrt", [2.0]))
  println("---")
  println(run_int_command("factorial", [10]))
  println("---")
  println(run_int_command("gcd", [12, 18]))
  println("---")
  println(run_int_command("isprime", [97]))
  println("---")
  println(run_int_command("fibonacci", [20]))
  println("---")
  println("Error handling demo:")
  println(run_command("mean", []))
  println(run_command("sqrt", [-1.0]))
  println("---")
  println("Help:")
  println(cmd_help())
}

///|
/// 命令: version / Command: version.
pub fn cmd_version() -> String {
  "DataVerse v0.1.0-dev\nAI-oriented first-class data entity + full-domain data algorithm operator engine\nLicense: Apache-2.0\nTarget: wasm / native"
}

///|
/// 命令: help / Command: help.
pub fn cmd_help() -> String {
  "Usage: dataverse <command> [args...]\n\nCommands:\n  version            Show version info\n  help               Show this help message\n  stats              Show library statistics\n  mean <nums...>     Compute mean of numbers\n  std <nums...>      Compute standard deviation\n  sum <nums...>      Compute sum of numbers\n  sort <nums...>     Sort numbers ascending\n  sqrt <num>         Compute square root\n  factorial <n>      Compute n!\n  gcd <a> <b>        Compute gcd(a, b)\n  isprime <n>        Check if n is prime\n  fibonacci <n>      Compute nth Fibonacci number\n\nExamples:\n  dataverse mean 1 2 3 4 5\n  dataverse sort 5 3 1 4 2\n  dataverse sqrt 2"
}

///|
/// 命令: stats / Command: stats.
pub fn cmd_stats() -> String {
  "DataVerse Library Statistics\n===========================\n\nPackages:     1,629+\nSource files: 17,975+\npub fn:       212,463+\npub struct:   1,610+\npub trait:    26 (20 core + 6 mock)\nTests:        1,732+\nproof_assert: 94+\nDomains:      20 (extcore) + 12 (opcore) + 11 (learncore)\n\nError handling: Result[T, DataVerseError] (6 error categories)\nTrait system: 20 pub(open) trait with sub-trait hierarchy"
}

///|
/// 命令: mean / Command: mean.
pub fn cmd_mean(nums : Array[Double]) -> String {
  match @_common.safe_mean(nums) {
    Ok(v) => "mean = " + v.to_string()
    Err(e) => "Error: " + @error.error_message(e)
  }
}

///|
/// 命令: std / Command: std.
pub fn cmd_std(nums : Array[Double]) -> String {
  match @_common.safe_std(nums) {
    Ok(v) => "std = " + v.to_string()
    Err(e) => "Error: " + @error.error_message(e)
  }
}

///|
/// 命令: sum / Command: sum.
pub fn cmd_sum(nums : Array[Double]) -> String {
  if nums.length() == 0 {
    return "Error: no numbers provided"
  }
  "sum = " + @_common.sum(nums).to_string()
}

///|
/// 命令: sort / Command: sort.
pub fn cmd_sort(nums : Array[Double]) -> String {
  if nums.length() == 0 {
    return "Error: no numbers provided"
  }
  let sorted = @_common.sort(nums)
  let mut result = "sorted = ["
  let mut first = true
  for v in sorted {
    if first {
      first = false
    } else {
      result = result + ", "
    }
    result = result + v.to_string()
  }
  result = result + "]"
  result
}

///|
/// 命令: sqrt / Command: sqrt.
pub fn cmd_sqrt(nums : Array[Double]) -> String {
  if nums.length() == 0 {
    return "Error: no number provided"
  }
  match @_common.safe_sqrt(nums[0]) {
    Ok(v) => "sqrt = " + v.to_string()
    Err(e) => "Error: " + @error.error_message(e)
  }
}

///|
/// 命令: factorial / Command: factorial.
pub fn cmd_factorial(args : Array[Int]) -> String {
  if args.length() == 0 {
    return "Error: no integer provided"
  }
  let n = args[0]
  match @_common.safe_factorial(n) {
    Ok(v) => "factorial(" + n.to_string() + ") = " + v.to_string()
    Err(e) => "Error: " + @error.error_message(e)
  }
}

///|
/// 命令: gcd / Command: gcd.
pub fn cmd_gcd(args : Array[Int]) -> String {
  if args.length() < 2 {
    return "Error: need two integers"
  }
  "gcd(" + args[0].to_string() + ", " + args[1].to_string() + ") = " + @_common.gcd(args[0], args[1]).to_string()
}

///|
/// 命令: isprime / Command: isprime.
pub fn cmd_isprime(args : Array[Int]) -> String {
  if args.length() == 0 {
    return "Error: no integer provided"
  }
  let n = args[0]
  if @_common.is_prime(n) {
    n.to_string() + " is prime"
  } else {
    n.to_string() + " is not prime"
  }
}

///|
/// 命令: fibonacci / Command: fibonacci.
pub fn cmd_fibonacci(args : Array[Int]) -> String {
  if args.length() == 0 {
    return "Error: no integer provided"
  }
  let n = args[0]
  "fibonacci(" + n.to_string() + ") = " + @_common.fibonacci(n).to_string()
}
