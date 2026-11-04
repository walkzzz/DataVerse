///|
fn[A] array_length(arr : Array[A]) -> Int32 {
  arr.length()
}

///===
/// opcore/quantum_comp 量子计算算子 / Quantum Computing Operators
/// S12 Phase 12 — 量子态/量子门/量子线路/量子算法
/// 量子计算模拟：态矢量模拟器 + 量子门 + 量子算法

///|
/// 复数 / Complex number (re, im)
pub struct Complex {
  re : Double
  im : Double
}

///|
/// 构造复数
pub fn quantum_comp_make_complex(re : Double, im : Double) -> Complex {
  { re, im, }
}

///|
/// 复数加法
pub fn quantum_comp_cadd(a : Complex, b : Complex) -> Complex {
  { re: a.re + b.re, im: a.im + b.im, }
}

///|
/// 复数减法
pub fn quantum_comp_csub(a : Complex, b : Complex) -> Complex {
  { re: a.re - b.re, im: a.im - b.im, }
}

///|
/// 复数乘法
pub fn quantum_comp_cmul(a : Complex, b : Complex) -> Complex {
  { re: a.re * b.re - a.im * b.im, im: a.re * b.im + a.im * b.re, }
}

///|
/// 复数模的平方
pub fn quantum_comp_cabs2(a : Complex) -> Double {
  a.re * a.re + a.im * a.im
}

///|
/// 复数模
pub fn quantum_comp_cabs(a : Complex) -> Double {
  quantum_comp_sqrt_(a.re * a.re + a.im * a.im)
}

///|
/// 复数共轭
pub fn quantum_comp_cconj(a : Complex) -> Complex {
  { re: a.re, im: -a.im, }
}

///|
/// 复数标量乘
pub fn quantum_comp_cscale(a : Complex, s : Double) -> Complex {
  { re: a.re * s, im: a.im * s, }
}

///|
/// 零复数
pub fn quantum_comp_czero() -> Complex {
  { re: 0.0, im: 0.0, }
}

///|
/// 单位复数
pub fn quantum_comp_cone() -> Complex {
  { re: 1.0, im: 0.0, }
}

///|
/// 虚数单位
pub fn quantum_comp_ci() -> Complex {
  { re: 0.0, im: 1.0, }
}

///|
/// 复数相等判断（近似）
pub fn quantum_comp_ceq(a : Complex, b : Complex) -> Bool {
  quantum_comp_abs_double(a.re - b.re) < 0.0000000001 &&
  quantum_comp_abs_double(a.im - b.im) < 0.0000000001
}

///|
/// 复数转字符串
pub fn quantum_comp_cto_string(a : Complex) -> String {
  let re_str = quantum_comp_double_to_string(a.re)
  let im_str = quantum_comp_double_to_string(quantum_comp_abs_double(a.im))
  if a.im >= 0.0 {
    re_str + "+" + im_str + "i"
  } else {
    re_str + "-" + im_str + "i"
  }
}

///|
///===
/// 量子比特态 / Qubit state — 归一化复向量
pub struct QubitState {
  amplitudes : Array[Complex]
  num_qubits : Int32
}

///|
/// 构造量子态
pub fn quantum_comp_make_qubit_state(
  amplitudes : Array[Complex],
  num_qubits : Int32,
) -> QubitState {
  { amplitudes, num_qubits, }
}

///|
/// |0⟩ 态
pub fn quantum_comp_ket0() -> QubitState {
  { amplitudes: [quantum_comp_cone(), quantum_comp_czero()], num_qubits: 1, }
}

///|
/// |1⟩ 态
pub fn quantum_comp_ket1() -> QubitState {
  { amplitudes: [quantum_comp_czero(), quantum_comp_cone()], num_qubits: 1, }
}

///|
/// |+⟩ 态 (Hadamard|0⟩)
pub fn quantum_comp_ket_plus() -> QubitState {
  let inv_sqrt2 = 1.0 / quantum_comp_sqrt_(2.0)
  {
    amplitudes: [quantum_comp_cscale(quantum_comp_cone(), inv_sqrt2), quantum_comp_cscale(quantum_comp_cone(), inv_sqrt2)],
    num_qubits: 1,
  }
}

///|
/// |-⟩ 态 (Hadamard|1⟩)
pub fn quantum_comp_ket_minus() -> QubitState {
  let inv_sqrt2 = 1.0 / quantum_comp_sqrt_(2.0)
  {
    amplitudes: [quantum_comp_cscale(quantum_comp_cone(), inv_sqrt2), quantum_comp_cscale(quantum_comp_cone(), -inv_sqrt2)],
    num_qubits: 1,
  }
}

///|
/// Bell 态 |Φ+⟩
pub fn quantum_comp_bell_state() -> QubitState {
  let inv_sqrt2 = 1.0 / quantum_comp_sqrt_(2.0)
  {
    amplitudes: [
      quantum_comp_cscale(quantum_comp_cone(), inv_sqrt2),
      quantum_comp_czero(),
      quantum_comp_czero(),
      quantum_comp_cscale(quantum_comp_cone(), inv_sqrt2),
    ],
    num_qubits: 2,
  }
}

///|
/// 量子态归一化
pub fn quantum_comp_normalize_state(state : QubitState) -> QubitState {
  let norm = quantum_comp_sqrt_(
    array_fold(state.amplitudes, 0.0, fn(acc, a) { acc + quantum_comp_cabs2(a) }),
  )
  if norm < 0.000000000000001 {
    state
  } else {
    let inv_norm = 1.0 / norm
    {
      amplitudes: array_map(state.amplitudes, fn(a) { quantum_comp_cscale(a, inv_norm) }),
      num_qubits: state.num_qubits,
    }
  }
}

///|
/// 量子态内积
pub fn quantum_comp_inner_product(a : QubitState, b : QubitState) -> Complex {
  let n = array_length(a.amplitudes)
  let mut result = quantum_comp_czero()
  for i in 0..<n {
    result = quantum_comp_cadd(result, quantum_comp_cmul(quantum_comp_cconj(a.amplitudes[i]), b.amplitudes[i]))
  }
  result
}

///|
/// 量子态概率
pub fn quantum_comp_probability(state : QubitState, index : Int32) -> Double {
  if index < 0 || index >= array_length(state.amplitudes) {
    0.0
  } else {
    quantum_comp_cabs2(state.amplitudes[index])
  }
}

///|
/// 量子态测量（计算基）
pub fn quantum_comp_measure(state : QubitState, qubit_index : Int32) -> Int32 {
  let n = array_length(state.amplitudes)
  let mut p0 = 0.0
  for i in 0..<n {
    if i / quantum_comp_pow2(qubit_index) % 2 == 0 {
      p0 = p0 + quantum_comp_cabs2(state.amplitudes[i])
    }
  }
  if p0 > 0.5 {
    0
  } else {
    1
  }
}

///|
///===
/// 量子门 / Quantum gates — 2x2 和 4x4 复矩阵
pub struct QuantumGate {
  matrix : Array[Array[Complex]]
  name : String
  num_qubits : Int32
}

///|
/// 构造量子门
pub fn quantum_comp_make_gate(
  matrix : Array[Array[Complex]],
  name : String,
  num_qubits : Int32,
) -> QuantumGate {
  { matrix, name, num_qubits, }
}

///|
/// Hadamard 门
pub fn quantum_comp_hadamard_gate() -> QuantumGate {
  let inv_sqrt2 = 1.0 / quantum_comp_sqrt_(2.0)
  let h = inv_sqrt2
  quantum_comp_make_gate(
    [
      [quantum_comp_make_complex(h, 0.0), quantum_comp_make_complex(h, 0.0)],
      [quantum_comp_make_complex(h, 0.0), quantum_comp_make_complex(-h, 0.0)],
    ],
    "H",
    1,
  )
}

///|
/// Pauli-X 门（NOT 门）
pub fn quantum_comp_pauli_x_gate() -> QuantumGate {
  quantum_comp_make_gate([[quantum_comp_czero(), quantum_comp_cone()], [quantum_comp_cone(), quantum_comp_czero()]], "X", 1)
}

///|
/// Pauli-Y 门
pub fn quantum_comp_pauli_y_gate() -> QuantumGate {
  quantum_comp_make_gate(
    [[quantum_comp_czero(), quantum_comp_make_complex(0.0, -1.0)], [quantum_comp_make_complex(0.0, 1.0), quantum_comp_czero()]],
    "Y",
    1,
  )
}

///|
/// Pauli-Z 门
pub fn quantum_comp_pauli_z_gate() -> QuantumGate {
  quantum_comp_make_gate([[quantum_comp_cone(), quantum_comp_czero()], [quantum_comp_czero(), quantum_comp_make_complex(-1.0, 0.0)]], "Z", 1)
}

///|
/// S 门（相位门）
pub fn quantum_comp_s_gate() -> QuantumGate {
  quantum_comp_make_gate([[quantum_comp_cone(), quantum_comp_czero()], [quantum_comp_czero(), quantum_comp_make_complex(0.0, 1.0)]], "S", 1)
}

///|
/// T 门
pub fn quantum_comp_t_gate() -> QuantumGate {
  let phase = 3.14159265358979323846 / 4.0
  quantum_comp_make_gate(
    [[quantum_comp_cone(), quantum_comp_czero()], [quantum_comp_czero(), quantum_comp_make_complex(quantum_comp_cos_(phase), quantum_comp_sin_(phase))]],
    "T",
    1,
  )
}

///|
/// CNOT 门
pub fn quantum_comp_cnot_gate() -> QuantumGate {
  quantum_comp_make_gate(
    [
      [quantum_comp_cone(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero()],
      [quantum_comp_czero(), quantum_comp_cone(), quantum_comp_czero(), quantum_comp_czero()],
      [quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_cone()],
      [quantum_comp_czero(), quantum_comp_czero(), quantum_comp_cone(), quantum_comp_czero()],
    ],
    "CNOT",
    2,
  )
}

///|
/// SWAP 门
pub fn quantum_comp_swap_gate() -> QuantumGate {
  quantum_comp_make_gate(
    [
      [quantum_comp_cone(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero()],
      [quantum_comp_czero(), quantum_comp_czero(), quantum_comp_cone(), quantum_comp_czero()],
      [quantum_comp_czero(), quantum_comp_cone(), quantum_comp_czero(), quantum_comp_czero()],
      [quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_cone()],
    ],
    "SWAP",
    2,
  )
}

///|
/// Toffoli 门（CCNOT）
pub fn quantum_comp_toffoli_gate() -> QuantumGate {
  let n = 8
  let matrix = Array::make(n, Array::make(n, quantum_comp_czero()))
  for i in 0..<6 {
    matrix[i][i] = quantum_comp_cone()
  }
  matrix[6][7] = quantum_comp_cone()
  matrix[7][6] = quantum_comp_cone()
  quantum_comp_make_gate(matrix, "Toffoli", 3)
}

///|
/// 恒等门
pub fn quantum_comp_identity_gate(num_qubits : Int32) -> QuantumGate {
  let n = quantum_comp_pow2(num_qubits)
  let matrix = Array::make(n, Array::make(n, quantum_comp_czero()))
  for i in 0..<n {
    matrix[i][i] = quantum_comp_cone()
  }
  quantum_comp_make_gate(matrix, "I", num_qubits)
}

///|
/// 门应用于态
pub fn quantum_comp_apply_gate(gate : QuantumGate, state : QubitState) -> QubitState {
  let n = array_length(gate.matrix)
  let new_amp = Array::make(n, quantum_comp_czero())
  for i in 0..<n {
    let mut sum = quantum_comp_czero()
    for j in 0..<n {
      if j < array_length(state.amplitudes) {
        sum = quantum_comp_cadd(sum, quantum_comp_cmul(gate.matrix[i][j], state.amplitudes[j]))
      }
    }
    new_amp[i] = sum
  }
  { amplitudes: new_amp, num_qubits: state.num_qubits, }
}

///|
/// 门张量积
pub fn quantum_comp_tensor_gate(a : QuantumGate, b : QuantumGate) -> QuantumGate {
  let na = array_length(a.matrix)
  let nb = array_length(b.matrix)
  let n = na * nb
  let matrix = Array::make(n, Array::make(n, quantum_comp_czero()))
  for i in 0..<na {
    for j in 0..<na {
      for k in 0..<nb {
        for l in 0..<nb {
          matrix[i * nb + k][j * nb + l] = quantum_comp_cmul(a.matrix[i][j], b.matrix[k][l])
        }
      }
    }
  }
  quantum_comp_make_gate(matrix, a.name + "⊗" + b.name, a.num_qubits + b.num_qubits)
}

///|
/// 门共轭转置（†）
pub fn quantum_comp_gate_dagger(gate : QuantumGate) -> QuantumGate {
  let n = array_length(gate.matrix)
  let matrix = Array::make(n, Array::make(n, quantum_comp_czero()))
  for i in 0..<n {
    for j in 0..<n {
      matrix[i][j] = quantum_comp_cconj(gate.matrix[j][i])
    }
  }
  quantum_comp_make_gate(matrix, gate.name + "†", gate.num_qubits)
}

///|
///===
/// 量子线路 / Quantum circuit
pub struct QuantumCircuit {
  gates : Array[(QuantumGate, Array[Int32])]
  num_qubits : Int32
}

///|
/// 构造量子线路
pub fn quantum_comp_make_circuit(num_qubits : Int32) -> QuantumCircuit {
  { gates: [], num_qubits, }
}

///|
/// 添加门到线路
pub fn quantum_comp_add_gate(
  circuit : QuantumCircuit,
  gate : QuantumGate,
  targets : Array[Int32],
) -> QuantumCircuit {
  {
    gates: array_append(circuit.gates, [(gate, targets)]),
    num_qubits: circuit.num_qubits,
  }
}

///|
/// 线路深度
pub fn quantum_comp_circuit_depth(circuit : QuantumCircuit) -> Int32 {
  array_length(circuit.gates)
}

///|
/// 执行线路
pub fn quantum_comp_run_circuit(
  circuit : QuantumCircuit,
  initial : QubitState,
) -> QubitState {
  let mut state = initial
  for i in 0..<array_length(circuit.gates) {
    let pair = circuit.gates[i]
    let gate = pair.0
    state = quantum_comp_apply_gate(gate, state)
  }
  state
}

///|
/// 线路转字符串
pub fn quantum_comp_circuit_to_string(circuit : QuantumCircuit) -> String {
  let mut result = "Circuit(" + quantum_comp_int_to_string(circuit.num_qubits) + " qubits): "
  for i in 0..<array_length(circuit.gates) {
    let pair = circuit.gates[i]
    if i > 0 {
      result = result + " -> "
    }
    result = result + pair.0.name
  }
  result
}

///|
///===
/// 量子傅里叶变换 / Quantum Fourier Transform (QFT)
pub fn quantum_comp_qft_circuit(num_qubits : Int32) -> QuantumCircuit {
  let mut circuit = quantum_comp_make_circuit(num_qubits)
  for i in 0..<num_qubits {
    circuit = quantum_comp_add_gate(circuit, quantum_comp_hadamard_gate(), [i])
    for j in (i + 1)..<num_qubits {
      let angle = 3.14159265358979323846 / quantum_comp_pow2_double(j - i)
      let phase_gate = quantum_comp_make_gate(
        [[quantum_comp_cone(), quantum_comp_czero()], [quantum_comp_czero(), quantum_comp_make_complex(quantum_comp_cos_(angle), quantum_comp_sin_(angle))]],
        "R" + quantum_comp_int_to_string(j - i),
        1,
      )
      circuit = quantum_comp_add_gate(circuit, phase_gate, [j])
    }
  }
  circuit
}

///|
///===
/// Grover 搜索算法 / Grover's search
pub struct GroverOracle {
  marked : Array[Int32]
}

///|
/// 构造 Grover oracle
pub fn quantum_comp_make_grover_oracle(marked : Array[Int32]) -> GroverOracle {
  { marked, }
}

///|
/// Oracle 判断是否标记
pub fn quantum_comp_oracle_check(oracle : GroverOracle, index : Int32) -> Bool {
  quantum_comp_array_contains(oracle.marked, index)
}

///|
/// Grover 迭代次数
pub fn quantum_comp_grover_iterations(n : Int32, m : Int32) -> Int32 {
  if m == 0 {
    0
  } else {
    let ratio = quantum_comp_int_to_double(n) / quantum_comp_int_to_double(m)
    let pi_over_4 = 3.14159265358979323846 / 4.0
    quantum_comp_int_of_double(pi_over_4 * quantum_comp_sqrt_(ratio))
  }
}

///|
/// Grover 搜索
pub fn quantum_comp_grover_search(oracle : GroverOracle, num_qubits : Int32) -> Int32 {
  let n = quantum_comp_pow2(num_qubits)
  let iterations = quantum_comp_grover_iterations(n, array_length(oracle.marked))
  let inv_sqrt_n = 1.0 / quantum_comp_sqrt_(quantum_comp_int_to_double(n))
  let state = quantum_comp_make_qubit_state(
    array_map(Array::make(n, 0), fn(_) { quantum_comp_cscale(quantum_comp_cone(), inv_sqrt_n) }),
    num_qubits,
  )
  for _ in 0..<iterations {
    for i in 0..<array_length(oracle.marked) {
      let idx = oracle.marked[i]
      state.amplitudes[idx] = quantum_comp_cscale(state.amplitudes[idx], -1.0)
    }
    let mut mean = array_fold(state.amplitudes, quantum_comp_czero(), fn(acc, a) {
      quantum_comp_cadd(acc, a)
    })
    mean = quantum_comp_cscale(mean, 2.0 / quantum_comp_int_to_double(n))
    for i in 0..<n {
      state.amplitudes[i] = quantum_comp_csub(quantum_comp_cscale(mean, 1.0), state.amplitudes[i])
    }
  }
  let mut best = 0
  let mut best_prob = 0.0
  for i in 0..<n {
    let p = quantum_comp_probability(state, i)
    if p > best_prob {
      best_prob = p
      best = i
    }
  }
  best
}

///===
/// 量子纠缠 / Quantum entanglement

///|
/// 纠缠熵
pub fn quantum_comp_entanglement_entropy(state : QubitState) -> Double {
  let n = array_length(state.amplitudes)
  let mut entropy = 0.0
  for i in 0..<n {
    let p = quantum_comp_probability(state, i)
    if p > 0.000000000000001 {
      entropy = entropy - p * quantum_comp_ln_(p)
    }
  }
  entropy
}

///|
/// 约化密度矩阵迹
pub fn quantum_comp_partial_trace(state : QubitState, _keep : Array[Int32]) -> Double {
  let n = array_length(state.amplitudes)
  let mut trace = 0.0
  for i in 0..<n {
    let p = quantum_comp_probability(state, i)
    trace = trace + p
  }
  trace
}

///|
/// Schmidt 分解（简化）
pub fn quantum_comp_schmidt_number(state : QubitState) -> Int32 {
  let n = array_length(state.amplitudes)
  let mut count = 0
  for i in 0..<n {
    if quantum_comp_probability(state, i) > 0.0000000001 {
      count = count + 1
    }
  }
  count
}

///===
/// 量子纠错 / Quantum error correction

///|
/// 3 比特重复码编码
pub fn quantum_comp_repetition_encode(bit : Int32) -> QubitState {
  if bit == 0 {
    quantum_comp_make_qubit_state(
      [quantum_comp_cone(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero()],
      3,
    )
  } else {
    quantum_comp_make_qubit_state(
      [quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_czero(), quantum_comp_cone()],
      3,
    )
  }
}

///|
/// 比特翻转纠错
pub fn quantum_comp_bit_flip_correct(state : QubitState) -> QubitState {
  let p0 = quantum_comp_probability(state, 0) +
    quantum_comp_probability(state, 3) +
    quantum_comp_probability(state, 5) +
    quantum_comp_probability(state, 6)
  let p1 = quantum_comp_probability(state, 1) +
    quantum_comp_probability(state, 2) +
    quantum_comp_probability(state, 4) +
    quantum_comp_probability(state, 7)
  if p0 > p1 {
    quantum_comp_repetition_encode(0)
  } else {
    quantum_comp_repetition_encode(1)
  }
}

///|
///===
/// 量子测量统计 / Measurement statistics
pub struct MeasurementResult {
  outcome : Int32
  probability : Double
}

///|
/// 构造测量结果
pub fn quantum_comp_make_measurement_result(
  outcome : Int32,
  probability : Double,
) -> MeasurementResult {
  { outcome, probability, }
}

///|
/// 所有测量结果概率
pub fn quantum_comp_measurement_probabilities(
  state : QubitState,
) -> Array[MeasurementResult] {
  let n = array_length(state.amplitudes)
  array_map(Array::make(n, 0), fn(i) {
    quantum_comp_make_measurement_result(i, quantum_comp_probability(state, i))
  })
}

///|
/// 期望值
pub fn quantum_comp_expectation_value(
  state : QubitState,
  observable : Array[Double],
) -> Double {
  let n = array_length(state.amplitudes)
  let mut exp_val = 0.0
  for i in 0..<n {
    if i < array_length(observable) {
      exp_val = exp_val + observable[i] * quantum_comp_probability(state, i)
    }
  }
  exp_val
}

///|
/// 方差
pub fn quantum_comp_variance_value(state : QubitState, observable : Array[Double]) -> Double {
  let mean = quantum_comp_expectation_value(state, observable)
  let n = array_length(state.amplitudes)
  let mut var_val = 0.0
  for i in 0..<n {
    if i < array_length(observable) {
      let diff = observable[i] - mean
      var_val = var_val + diff * diff * quantum_comp_probability(state, i)
    }
  }
  var_val
}

///|
///===
/// 辅助函数 / Helper functions
fn quantum_comp_pow2(n : Int32) -> Int32 {
  let mut result = 1
  for _ in 0..<n {
    result = result * 2
  }
  result
}

///|
fn quantum_comp_pow2_double(n : Int32) -> Double {
  quantum_comp_int_to_double(quantum_comp_pow2(n))
}

///|
fn quantum_comp_sqrt_(x : Double) -> Double {
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

///|
fn quantum_comp_abs_double(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn quantum_comp_cos_(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  let x2 = x * x
  for i in 1..<=10 {
    term = -term * x2 / (quantum_comp_int_to_double(2 * i - 1) * quantum_comp_int_to_double(2 * i))
    result = result + term
  }
  result
}

///|
fn quantum_comp_sin_(x : Double) -> Double {
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<=10 {
    term = -term * x2 / (quantum_comp_int_to_double(2 * i) * quantum_comp_int_to_double(2 * i + 1))
    result = result + term
  }
  result
}

///|
fn quantum_comp_ln_(x : Double) -> Double {
  if x <= 0.0 {
    -999999.0
  } else {
    let y = (x - 1.0) / (x + 1.0)
    let y2 = y * y
    let mut result = 0.0
    let mut term = y
    for i in 0..<50 {
      result = result + term / quantum_comp_int_to_double(2 * i + 1)
      term = term * y2
    }
    2.0 * result
  }
}

///|
fn quantum_comp_double_to_string(x : Double) -> String {
  let int_part = quantum_comp_int_of_double(x)
  let frac = x - quantum_comp_int_to_double(int_part)
  let frac_int = quantum_comp_int_of_double(quantum_comp_abs_double(frac) * 1000000.0)
  quantum_comp_int_to_string(int_part) + "." + quantum_comp_int_to_string(frac_int)
}

///|
fn[A, B] array_fold(arr : Array[A], init : B, f : (B, A) -> B) -> B {
  let mut result = init
  for i in 0..<array_length(arr) {
    result = f(result, arr[i])
  }
  result
}

///|
fn[A, B] array_map(arr : Array[A], f : (A) -> B) -> Array[B] {
  let n = array_length(arr)
  let result = Array::make(n, f(arr[0]))
  for i in 0..<n {
    result[i] = f(arr[i])
  }
  result
}

///|
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

///|
fn quantum_comp_array_contains(arr : Array[Int32], x : Int32) -> Bool {
  for i in 0..<array_length(arr) {
    if arr[i] == x {
      return true
    }
  }
  false
}

///|
fn quantum_comp_int_of_double(x : Double) -> Int32 {
  if x >= 0.0 {
    quantum_comp_int_of_double_impl(x)
  } else {
    -quantum_comp_int_of_double_impl(-x)
  }
}

///|
fn quantum_comp_int_of_double_impl(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn quantum_comp_int_to_double(n : Int32) -> Double {
  n.to_double()
}

///|
fn quantum_comp_int_to_string(n : Int32) -> String {
  n.to_string()
}
