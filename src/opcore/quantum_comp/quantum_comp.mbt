fn[A] array_length(arr : Array[A]) -> Int {
  arr.length()
}

///===
/// opcore/quantum_comp 量子计算算子 / Quantum Computing Operators
/// S12 Phase 12 — 量子态/量子门/量子线路/量子算法
/// 量子计算模拟：态矢量模拟器 + 量子门 + 量子算法

/// 复数 / Complex number (re, im)
pub struct Complex {
  re : Double
  im : Double
}

/// 构造复数
pub fn make_complex(re : Double, im : Double) -> Complex {
  { re, im }
}

/// 复数加法
pub fn cadd(a : Complex, b : Complex) -> Complex {
  { re: a.re + b.re, im: a.im + b.im }
}

/// 复数减法
pub fn csub(a : Complex, b : Complex) -> Complex {
  { re: a.re - b.re, im: a.im - b.im }
}

/// 复数乘法
pub fn cmul(a : Complex, b : Complex) -> Complex {
  { re: a.re * b.re - a.im * b.im, im: a.re * b.im + a.im * b.re }
}

/// 复数模的平方
pub fn cabs2(a : Complex) -> Double {
  a.re * a.re + a.im * a.im
}

/// 复数模
pub fn cabs(a : Complex) -> Double {
  sqrt_(a.re * a.re + a.im * a.im)
}

/// 复数共轭
pub fn cconj(a : Complex) -> Complex {
  { re: a.re, im: -a.im }
}

/// 复数标量乘
pub fn cscale(a : Complex, s : Double) -> Complex {
  { re: a.re * s, im: a.im * s }
}

/// 零复数
pub fn czero() -> Complex {
  { re: 0.0, im: 0.0 }
}

/// 单位复数
pub fn cone() -> Complex {
  { re: 1.0, im: 0.0 }
}

/// 虚数单位
pub fn ci() -> Complex {
  { re: 0.0, im: 1.0 }
}

/// 复数相等判断（近似）
pub fn ceq(a : Complex, b : Complex) -> Bool {
  abs_double(a.re - b.re) < 0.0000000001 && abs_double(a.im - b.im) < 0.0000000001
}

/// 复数转字符串
pub fn cto_string(a : Complex) -> String {
  let re_str = double_to_string(a.re)
  let im_str = double_to_string(abs_double(a.im))
  if a.im >= 0.0 {
    re_str + "+" + im_str + "i"
  } else {
    re_str + "-" + im_str + "i"
  }
}

///===
/// 量子比特态 / Qubit state — 归一化复向量

pub struct QubitState {
  amplitudes : Array[Complex]
  num_qubits : Int
}

/// 构造量子态
pub fn make_qubit_state(amplitudes : Array[Complex], num_qubits : Int) -> QubitState {
  { amplitudes, num_qubits }
}

/// |0⟩ 态
pub fn ket0() -> QubitState {
  { amplitudes: [cone(), czero()], num_qubits: 1 }
}

/// |1⟩ 态
pub fn ket1() -> QubitState {
  { amplitudes: [czero(), cone()], num_qubits: 1 }
}

/// |+⟩ 态 (Hadamard|0⟩)
pub fn ket_plus() -> QubitState {
  let inv_sqrt2 = 1.0 / sqrt_(2.0)
  { amplitudes: [cscale(cone(), inv_sqrt2), cscale(cone(), inv_sqrt2)], num_qubits: 1 }
}

/// |-⟩ 态 (Hadamard|1⟩)
pub fn ket_minus() -> QubitState {
  let inv_sqrt2 = 1.0 / sqrt_(2.0)
  { amplitudes: [cscale(cone(), inv_sqrt2), cscale(cone(), -inv_sqrt2)], num_qubits: 1 }
}

/// Bell 态 |Φ+⟩
pub fn bell_state() -> QubitState {
  let inv_sqrt2 = 1.0 / sqrt_(2.0)
  { amplitudes: [cscale(cone(), inv_sqrt2), czero(), czero(), cscale(cone(), inv_sqrt2)], num_qubits: 2 }
}

/// 量子态归一化
pub fn normalize_state(state : QubitState) -> QubitState {
  let norm = sqrt_(array_fold(state.amplitudes, 0.0, fn(acc, a) { acc + cabs2(a) }))
  if norm < 0.000000000000001 {
    state
  } else {
    let inv_norm = 1.0 / norm
    { amplitudes: array_map(state.amplitudes, fn(a) { cscale(a, inv_norm) }), num_qubits: state.num_qubits }
  }
}

/// 量子态内积
pub fn inner_product(a : QubitState, b : QubitState) -> Complex {
  let n = array_length(a.amplitudes)
  let mut result = czero()
  for i in 0..<n {
    result = cadd(result, cmul(cconj(a.amplitudes[i]), b.amplitudes[i]))
  }
  result
}

/// 量子态概率
pub fn probability(state : QubitState, index : Int) -> Double {
  if index < 0 || index >= array_length(state.amplitudes) {
    0.0
  } else {
    cabs2(state.amplitudes[index])
  }
}

/// 量子态测量（计算基）
pub fn measure(state : QubitState, qubit_index : Int) -> Int {
  let n = array_length(state.amplitudes)
  let mut p0 = 0.0
  for i in 0..<n {
    if (i / pow2(qubit_index)) % 2 == 0 {
      p0 = p0 + cabs2(state.amplitudes[i])
    }
  }
  if p0 > 0.5 {
    0
  } else {
    1
  }
}

///===
/// 量子门 / Quantum gates — 2x2 和 4x4 复矩阵

pub struct QuantumGate {
  matrix : Array[Array[Complex]]
  name : String
  num_qubits : Int
}

/// 构造量子门
pub fn make_gate(matrix : Array[Array[Complex]], name : String, num_qubits : Int) -> QuantumGate {
  { matrix, name, num_qubits }
}

/// Hadamard 门
pub fn hadamard_gate() -> QuantumGate {
  let inv_sqrt2 = 1.0 / sqrt_(2.0)
  let h = inv_sqrt2
  make_gate([
    [make_complex(h, 0.0), make_complex(h, 0.0)],
    [make_complex(h, 0.0), make_complex(-h, 0.0)],
  ], "H", 1)
}

/// Pauli-X 门（NOT 门）
pub fn pauli_x_gate() -> QuantumGate {
  make_gate([
    [czero(), cone()],
    [cone(), czero()],
  ], "X", 1)
}

/// Pauli-Y 门
pub fn pauli_y_gate() -> QuantumGate {
  make_gate([
    [czero(), make_complex(0.0, -1.0)],
    [make_complex(0.0, 1.0), czero()],
  ], "Y", 1)
}

/// Pauli-Z 门
pub fn pauli_z_gate() -> QuantumGate {
  make_gate([
    [cone(), czero()],
    [czero(), make_complex(-1.0, 0.0)],
  ], "Z", 1)
}

/// S 门（相位门）
pub fn s_gate() -> QuantumGate {
  make_gate([
    [cone(), czero()],
    [czero(), make_complex(0.0, 1.0)],
  ], "S", 1)
}

/// T 门
pub fn t_gate() -> QuantumGate {
  let phase = 3.14159265358979323846 / 4.0
  make_gate([
    [cone(), czero()],
    [czero(), make_complex(cos_(phase), sin_(phase))],
  ], "T", 1)
}

/// CNOT 门
pub fn cnot_gate() -> QuantumGate {
  make_gate([
    [cone(), czero(), czero(), czero()],
    [czero(), cone(), czero(), czero()],
    [czero(), czero(), czero(), cone()],
    [czero(), czero(), cone(), czero()],
  ], "CNOT", 2)
}

/// SWAP 门
pub fn swap_gate() -> QuantumGate {
  make_gate([
    [cone(), czero(), czero(), czero()],
    [czero(), czero(), cone(), czero()],
    [czero(), cone(), czero(), czero()],
    [czero(), czero(), czero(), cone()],
  ], "SWAP", 2)
}

/// Toffoli 门（CCNOT）
pub fn toffoli_gate() -> QuantumGate {
  let n = 8
  let matrix = Array::make(n, Array::make(n, czero()))
  for i in 0..<6 {
    matrix[i][i] = cone()
  }
  matrix[6][7] = cone()
  matrix[7][6] = cone()
  make_gate(matrix, "Toffoli", 3)
}

/// 恒等门
pub fn identity_gate(num_qubits : Int) -> QuantumGate {
  let n = pow2(num_qubits)
  let matrix = Array::make(n, Array::make(n, czero()))
  for i in 0..<n {
    matrix[i][i] = cone()
  }
  make_gate(matrix, "I", num_qubits)
}

/// 门应用于态
pub fn apply_gate(gate : QuantumGate, state : QubitState) -> QubitState {
  let n = array_length(gate.matrix)
  let new_amp = Array::make(n, czero())
  for i in 0..<n {
    let mut sum = czero()
    for j in 0..<n {
      if j < array_length(state.amplitudes) {
        sum = cadd(sum, cmul(gate.matrix[i][j], state.amplitudes[j]))
      }
    }
    new_amp[i] = sum
  }
  { amplitudes: new_amp, num_qubits: state.num_qubits }
}

/// 门张量积
pub fn tensor_gate(a : QuantumGate, b : QuantumGate) -> QuantumGate {
  let na = array_length(a.matrix)
  let nb = array_length(b.matrix)
  let n = na * nb
  let matrix = Array::make(n, Array::make(n, czero()))
  for i in 0..<na {
    for j in 0..<na {
      for k in 0..<nb {
        for l in 0..<nb {
          matrix[i * nb + k][j * nb + l] = cmul(a.matrix[i][j], b.matrix[k][l])
        }
      }
    }
  }
  make_gate(matrix, a.name + "⊗" + b.name, a.num_qubits + b.num_qubits)
}

/// 门共轭转置（†）
pub fn gate_dagger(gate : QuantumGate) -> QuantumGate {
  let n = array_length(gate.matrix)
  let matrix = Array::make(n, Array::make(n, czero()))
  for i in 0..<n {
    for j in 0..<n {
      matrix[i][j] = cconj(gate.matrix[j][i])
    }
  }
  make_gate(matrix, gate.name + "†", gate.num_qubits)
}

///===
/// 量子线路 / Quantum circuit

pub struct QuantumCircuit {
  gates : Array[(QuantumGate, Array[Int])]
  num_qubits : Int
}

/// 构造量子线路
pub fn make_circuit(num_qubits : Int) -> QuantumCircuit {
  { gates: [], num_qubits }
}

/// 添加门到线路
pub fn add_gate(circuit : QuantumCircuit, gate : QuantumGate, targets : Array[Int]) -> QuantumCircuit {
  { gates: array_append(circuit.gates, [(gate, targets)]), num_qubits: circuit.num_qubits }
}

/// 线路深度
pub fn circuit_depth(circuit : QuantumCircuit) -> Int {
  array_length(circuit.gates)
}

/// 执行线路
pub fn run_circuit(circuit : QuantumCircuit, initial : QubitState) -> QubitState {
  let mut state = initial
  for i in 0..<array_length(circuit.gates) {
    let pair = circuit.gates[i]
    let gate = pair.0
    state = apply_gate(gate, state)
  }
  state
}

/// 线路转字符串
pub fn circuit_to_string(circuit : QuantumCircuit) -> String {
  let mut result = "Circuit(" + int_to_string(circuit.num_qubits) + " qubits): "
  for i in 0..<array_length(circuit.gates) {
    let pair = circuit.gates[i]
    if i > 0 {
      result = result + " -> "
    }
    result = result + pair.0.name
  }
  result
}

///===
/// 量子傅里叶变换 / Quantum Fourier Transform (QFT)

pub fn qft_circuit(num_qubits : Int) -> QuantumCircuit {
  let mut circuit = make_circuit(num_qubits)
  for i in 0..<num_qubits {
    circuit = add_gate(circuit, hadamard_gate(), [i])
    for j in (i + 1)..<num_qubits {
      let angle = 3.14159265358979323846 / pow2_double(j - i)
      let phase_gate = make_gate([
        [cone(), czero()],
        [czero(), make_complex(cos_(angle), sin_(angle))],
      ], "R" + int_to_string(j - i), 1)
      circuit = add_gate(circuit, phase_gate, [j])
    }
  }
  circuit
}

///===
/// Grover 搜索算法 / Grover's search

pub struct GroverOracle {
  marked : Array[Int]
}

/// 构造 Grover oracle
pub fn make_grover_oracle(marked : Array[Int]) -> GroverOracle {
  { marked, }
}

/// Oracle 判断是否标记
pub fn oracle_check(oracle : GroverOracle, index : Int) -> Bool {
  array_contains(oracle.marked, index)
}

/// Grover 迭代次数
pub fn grover_iterations(n : Int, m : Int) -> Int {
  if m == 0 {
    0
  } else {
    let ratio = int_to_double(n) / int_to_double(m)
    let pi_over_4 = 3.14159265358979323846 / 4.0
    int_of_double(pi_over_4 * sqrt_(ratio))
  }
}

/// Grover 搜索
pub fn grover_search(oracle : GroverOracle, num_qubits : Int) -> Int {
  let n = pow2(num_qubits)
  let iterations = grover_iterations(n, array_length(oracle.marked))
  let inv_sqrt_n = 1.0 / sqrt_(int_to_double(n))
  let state = make_qubit_state(
    array_map(Array::make(n, 0), fn(_) { cscale(cone(), inv_sqrt_n) }),
    num_qubits
  )
  for _ in 0..<iterations {
    for i in 0..<array_length(oracle.marked) {
      let idx = oracle.marked[i]
      state.amplitudes[idx] = cscale(state.amplitudes[idx], -1.0)
    }
    let mut mean = array_fold(state.amplitudes, czero(), fn(acc, a) { cadd(acc, a) })
    mean = cscale(mean, 2.0 / int_to_double(n))
    for i in 0..<n {
      state.amplitudes[i] = csub(cscale(mean, 1.0), state.amplitudes[i])
    }
  }
  let mut best = 0
  let mut best_prob = 0.0
  for i in 0..<n {
    let p = probability(state, i)
    if p > best_prob {
      best_prob = p
      best = i
    }
  }
  best
}

///===
/// 量子纠缠 / Quantum entanglement

/// 纠缠熵
pub fn entanglement_entropy(state : QubitState) -> Double {
  let n = array_length(state.amplitudes)
  let mut entropy = 0.0
  for i in 0..<n {
    let p = probability(state, i)
    if p > 0.000000000000001 {
      entropy = entropy - p * ln_(p)
    }
  }
  entropy
}

/// 约化密度矩阵迹
pub fn partial_trace(state : QubitState, keep : Array[Int]) -> Double {
  let n = array_length(state.amplitudes)
  let mut trace = 0.0
  for i in 0..<n {
    let p = probability(state, i)
    trace = trace + p
  }
  trace
}

/// Schmidt 分解（简化）
pub fn schmidt_number(state : QubitState) -> Int {
  let n = array_length(state.amplitudes)
  let mut count = 0
  for i in 0..<n {
    if probability(state, i) > 0.0000000001 {
      count = count + 1
    }
  }
  count
}

///===
/// 量子纠错 / Quantum error correction

/// 3 比特重复码编码
pub fn repetition_encode(bit : Int) -> QubitState {
  if bit == 0 {
    make_qubit_state([cone(), czero(), czero(), czero(), czero(), czero(), czero(), czero()], 3)
  } else {
    make_qubit_state([czero(), czero(), czero(), czero(), czero(), czero(), czero(), cone()], 3)
  }
}

/// 比特翻转纠错
pub fn bit_flip_correct(state : QubitState) -> QubitState {
  let p0 = probability(state, 0) + probability(state, 3) + probability(state, 5) + probability(state, 6)
  let p1 = probability(state, 1) + probability(state, 2) + probability(state, 4) + probability(state, 7)
  if p0 > p1 {
    repetition_encode(0)
  } else {
    repetition_encode(1)
  }
}

///===
/// 量子测量统计 / Measurement statistics

pub struct MeasurementResult {
  outcome : Int
  probability : Double
}

/// 构造测量结果
pub fn make_measurement_result(outcome : Int, probability : Double) -> MeasurementResult {
  { outcome, probability }
}

/// 所有测量结果概率
pub fn measurement_probabilities(state : QubitState) -> Array[MeasurementResult] {
  let n = array_length(state.amplitudes)
  array_map(Array::make(n, 0), fn(i) { make_measurement_result(i, probability(state, i)) })
}

/// 期望值
pub fn expectation_value(state : QubitState, observable : Array[Double]) -> Double {
  let n = array_length(state.amplitudes)
  let mut exp_val = 0.0
  for i in 0..<n {
    if i < array_length(observable) {
      exp_val = exp_val + observable[i] * probability(state, i)
    }
  }
  exp_val
}

/// 方差
pub fn variance_value(state : QubitState, observable : Array[Double]) -> Double {
  let mean = expectation_value(state, observable)
  let n = array_length(state.amplitudes)
  let mut var_val = 0.0
  for i in 0..<n {
    if i < array_length(observable) {
      let diff = observable[i] - mean
      var_val = var_val + diff * diff * probability(state, i)
    }
  }
  var_val
}

///===
/// 辅助函数 / Helper functions

fn pow2(n : Int) -> Int {
  let mut result = 1
  for _ in 0..<n {
    result = result * 2
  }
  result
}

fn pow2_double(n : Int) -> Double {
  int_to_double(pow2(n))
}

fn sqrt_(x : Double) -> Double {
  if x < 0.0 {
    0.0
  } else if x == 0.0 {
    0.0
  } else {
    let mut guess = x / 2.0
    if guess < 1.0 {
      guess = 1.0
    }
    for _ in 0..<50 {
      guess = (guess + x / guess) / 2.0
    }
    guess
  }
}

fn abs_double(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn cos_(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  let x2 = x * x
  for i in 1..<=10 {
    term = -term * x2 / (int_to_double(2 * i - 1) * int_to_double(2 * i))
    result = result + term
  }
  result
}

fn sin_(x : Double) -> Double {
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<=10 {
    term = -term * x2 / (int_to_double(2 * i) * int_to_double(2 * i + 1))
    result = result + term
  }
  result
}

fn ln_(x : Double) -> Double {
  if x <= 0.0 {
    -999999.0
  } else {
    let y = (x - 1.0) / (x + 1.0)
    let y2 = y * y
    let mut result = 0.0
    let mut term = y
    for i in 0..<50 {
      result = result + term / int_to_double(2 * i + 1)
      term = term * y2
    }
    2.0 * result
  }
}

fn double_to_string(x : Double) -> String {
  let int_part = int_of_double(x)
  let frac = x - int_to_double(int_part)
  let frac_int = int_of_double(abs_double(frac) * 1000000.0)
  int_to_string(int_part) + "." + int_to_string(frac_int)
}

fn[A, B] array_fold(arr : Array[A], init : B, f : (B, A) -> B) -> B {
  let mut result = init
  for i in 0..<array_length(arr) {
    result = f(result, arr[i])
  }
  result
}

fn[A, B] array_map(arr : Array[A], f : (A) -> B) -> Array[B] {
  let n = array_length(arr)
  let result = Array::make(n, f(arr[0]))
  for i in 0..<n {
    result[i] = f(arr[i])
  }
  result
}

fn[A] array_append(arr : Array[A], elem : Array[A]) -> Array[A] {
  let n = array_length(arr)
  let m = array_length(elem)
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn array_contains(arr : Array[Int], x : Int) -> Bool {
  for i in 0..<array_length(arr) {
    if arr[i] == x {
      return true
    }
  }
  false
}

fn int_of_double(x : Double) -> Int {
  if x >= 0.0 {
    int_of_double_impl(x)
  } else {
    -int_of_double_impl(-x)
  }
}

fn int_of_double_impl(x : Double) -> Int {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

fn int_to_double(n : Int) -> Double {
  n.to_double()
}

fn int_to_string(n : Int) -> String {
  n.to_string()
}