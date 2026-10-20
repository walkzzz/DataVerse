///===
/// extcore/chem_mol_repr_smiles

pub(all) struct ChemmolreprsmilesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_smiles_make_point(x : Double, y : Double) -> ChemmolreprsmilesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_smiles_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsmilesPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprsmilesPoint::x(self : ChemmolreprsmilesPoint) -> Double { self.x }

pub fn ChemmolreprsmilesPoint::y(self : ChemmolreprsmilesPoint) -> Double { self.y }

pub fn ChemmolreprsmilesPoint::z(self : ChemmolreprsmilesPoint) -> Double { self.z }

pub fn ChemmolreprsmilesPoint::label(self : ChemmolreprsmilesPoint) -> Int { self.label }

pub fn ChemmolreprsmilesPoint::dist(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprsmilesPoint::add(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::sub(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::scale(self : ChemmolreprsmilesPoint, s : Double) -> ChemmolreprsmilesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprsmilesPoint::dot(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprsmilesPoint::cross(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprsmilesPoint::norm(self : ChemmolreprsmilesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprsmilesPoint::normalize(self : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsmilesPoint::negate(self : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::mid(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprsmilesPoint::lerp(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint, t : Double) -> ChemmolreprsmilesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprsmilesPoint::to_string(self : ChemmolreprsmilesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_smiles_make_series(vals : Array[Double], name : String) -> ChemmolreprsmilesSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprsmilesSeries::len(self : ChemmolreprsmilesSeries) -> Int { self.vals.length() }

pub fn ChemmolreprsmilesSeries::sum(self : ChemmolreprsmilesSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprsmilesSeries::mean(self : ChemmolreprsmilesSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprsmilesSeries::min(self : ChemmolreprsmilesSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprsmilesSeries::max(self : ChemmolreprsmilesSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprsmilesSeries::range(self : ChemmolreprsmilesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprsmilesSeries::variance(self : ChemmolreprsmilesSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprsmilesSeries::std(self : ChemmolreprsmilesSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprsmilesSeries::median(self : ChemmolreprsmilesSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprsmilesSeries::scale(self : ChemmolreprsmilesSeries, f : Double) -> ChemmolreprsmilesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::add(self : ChemmolreprsmilesSeries, other : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::sub(self : ChemmolreprsmilesSeries, other : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::normalize(self : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprsmilesSeries::cumsum(self : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::to_string(self : ChemmolreprsmilesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsmilesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_smiles_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsmilesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_smiles_matrix_identity(n : Int) -> ChemmolreprsmilesMatrix {
  let m = chem_mol_repr_smiles_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprsmilesMatrix::get(self : ChemmolreprsmilesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprsmilesMatrix::transpose(self : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprsmilesMatrix::add(self : ChemmolreprsmilesMatrix, other : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_smiles_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprsmilesMatrix::scale(self : ChemmolreprsmilesMatrix, s : Double) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprsmilesMatrix::multiply(self : ChemmolreprsmilesMatrix, other : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if self.cols != other.rows { return chem_mol_repr_smiles_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_smiles_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprsmilesMatrix::trace(self : ChemmolreprsmilesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprsmilesMatrix::det(self : ChemmolreprsmilesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprsmilesMatrix::norm(self : ChemmolreprsmilesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprsmilesMatrix::to_string(self : ChemmolreprsmilesMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolreprsmilesVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_smiles_make_vector(comps : Array[Double]) -> ChemmolreprsmilesVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_smiles_vector_zero(dim : Int) -> ChemmolreprsmilesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprsmilesVector::add(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsmilesVector::sub(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsmilesVector::scale(self : ChemmolreprsmilesVector, s : Double) -> ChemmolreprsmilesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprsmilesVector::dot(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprsmilesVector::norm(self : ChemmolreprsmilesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprsmilesVector::normalize(self : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsmilesVector::dist(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprsmilesVector::to_string(self : ChemmolreprsmilesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_smiles_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_smiles_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_smiles_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_smiles_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_smiles_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_smiles_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_smiles_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_smiles_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_smiles_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_smiles_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_smiles_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_smiles_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_smiles_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_smiles_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_smiles_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_smiles_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_smiles_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_smiles_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_smiles_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_smiles_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_smiles_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_smiles_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_smiles_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_smiles_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_smiles_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_smiles_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_smiles_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_smiles_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_smiles_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprsmilesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_frame_make(size : Int) -> ChemmolreprsmilesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_frame_len(s : ChemmolreprsmilesFrame) -> Int { s.size }

pub fn chem_mol_repr_smiles_frame_get(s : ChemmolreprsmilesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_frame_set(s : ChemmolreprsmilesFrame, i : Int, v : Double) -> ChemmolreprsmilesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_sum(s : ChemmolreprsmilesFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_frame_mean(s : ChemmolreprsmilesFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_frame_scale(s : ChemmolreprsmilesFrame, f : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_add(a : ChemmolreprsmilesFrame, b : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_frame_copy(s : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_fill(s : ChemmolreprsmilesFrame, v : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_min(s : ChemmolreprsmilesFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_frame_max(s : ChemmolreprsmilesFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_frame_to_string(s : ChemmolreprsmilesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_table_make(size : Int) -> ChemmolreprsmilesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_table_len(s : ChemmolreprsmilesTable) -> Int { s.size }

pub fn chem_mol_repr_smiles_table_get(s : ChemmolreprsmilesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_table_set(s : ChemmolreprsmilesTable, i : Int, v : Double) -> ChemmolreprsmilesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_sum(s : ChemmolreprsmilesTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_table_mean(s : ChemmolreprsmilesTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_table_scale(s : ChemmolreprsmilesTable, f : Double) -> ChemmolreprsmilesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_add(a : ChemmolreprsmilesTable, b : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_table_copy(s : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_fill(s : ChemmolreprsmilesTable, v : Double) -> ChemmolreprsmilesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_min(s : ChemmolreprsmilesTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_table_max(s : ChemmolreprsmilesTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_table_to_string(s : ChemmolreprsmilesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_graphn_make(size : Int) -> ChemmolreprsmilesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_graphn_len(s : ChemmolreprsmilesGraphN) -> Int { s.size }

pub fn chem_mol_repr_smiles_graphn_get(s : ChemmolreprsmilesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_graphn_set(s : ChemmolreprsmilesGraphN, i : Int, v : Double) -> ChemmolreprsmilesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_sum(s : ChemmolreprsmilesGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_graphn_mean(s : ChemmolreprsmilesGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_graphn_scale(s : ChemmolreprsmilesGraphN, f : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_add(a : ChemmolreprsmilesGraphN, b : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_graphn_copy(s : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_fill(s : ChemmolreprsmilesGraphN, v : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_min(s : ChemmolreprsmilesGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_graphn_max(s : ChemmolreprsmilesGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_graphn_to_string(s : ChemmolreprsmilesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_node_make(size : Int) -> ChemmolreprsmilesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_node_len(s : ChemmolreprsmilesNode) -> Int { s.size }

pub fn chem_mol_repr_smiles_node_get(s : ChemmolreprsmilesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_node_set(s : ChemmolreprsmilesNode, i : Int, v : Double) -> ChemmolreprsmilesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_sum(s : ChemmolreprsmilesNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_node_mean(s : ChemmolreprsmilesNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_node_scale(s : ChemmolreprsmilesNode, f : Double) -> ChemmolreprsmilesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_add(a : ChemmolreprsmilesNode, b : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_node_copy(s : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_fill(s : ChemmolreprsmilesNode, v : Double) -> ChemmolreprsmilesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_min(s : ChemmolreprsmilesNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_node_max(s : ChemmolreprsmilesNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_node_to_string(s : ChemmolreprsmilesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_edge_make(size : Int) -> ChemmolreprsmilesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_edge_len(s : ChemmolreprsmilesEdge) -> Int { s.size }

pub fn chem_mol_repr_smiles_edge_get(s : ChemmolreprsmilesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_edge_set(s : ChemmolreprsmilesEdge, i : Int, v : Double) -> ChemmolreprsmilesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_sum(s : ChemmolreprsmilesEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_edge_mean(s : ChemmolreprsmilesEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_edge_scale(s : ChemmolreprsmilesEdge, f : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_add(a : ChemmolreprsmilesEdge, b : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_edge_copy(s : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_fill(s : ChemmolreprsmilesEdge, v : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_min(s : ChemmolreprsmilesEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_edge_max(s : ChemmolreprsmilesEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_edge_to_string(s : ChemmolreprsmilesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_path_make(size : Int) -> ChemmolreprsmilesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_path_len(s : ChemmolreprsmilesPath) -> Int { s.size }

pub fn chem_mol_repr_smiles_path_get(s : ChemmolreprsmilesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_path_set(s : ChemmolreprsmilesPath, i : Int, v : Double) -> ChemmolreprsmilesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_sum(s : ChemmolreprsmilesPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_path_mean(s : ChemmolreprsmilesPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_path_scale(s : ChemmolreprsmilesPath, f : Double) -> ChemmolreprsmilesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_add(a : ChemmolreprsmilesPath, b : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_path_copy(s : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_fill(s : ChemmolreprsmilesPath, v : Double) -> ChemmolreprsmilesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_min(s : ChemmolreprsmilesPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_path_max(s : ChemmolreprsmilesPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_path_to_string(s : ChemmolreprsmilesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cluster_make(size : Int) -> ChemmolreprsmilesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_cluster_len(s : ChemmolreprsmilesCluster) -> Int { s.size }

pub fn chem_mol_repr_smiles_cluster_get(s : ChemmolreprsmilesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_cluster_set(s : ChemmolreprsmilesCluster, i : Int, v : Double) -> ChemmolreprsmilesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_sum(s : ChemmolreprsmilesCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_cluster_mean(s : ChemmolreprsmilesCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_cluster_scale(s : ChemmolreprsmilesCluster, f : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_add(a : ChemmolreprsmilesCluster, b : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_cluster_copy(s : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_fill(s : ChemmolreprsmilesCluster, v : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_min(s : ChemmolreprsmilesCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_cluster_max(s : ChemmolreprsmilesCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_cluster_to_string(s : ChemmolreprsmilesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_model_make(size : Int) -> ChemmolreprsmilesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_model_len(s : ChemmolreprsmilesModel) -> Int { s.size }

pub fn chem_mol_repr_smiles_model_get(s : ChemmolreprsmilesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_model_set(s : ChemmolreprsmilesModel, i : Int, v : Double) -> ChemmolreprsmilesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_sum(s : ChemmolreprsmilesModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_model_mean(s : ChemmolreprsmilesModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_model_scale(s : ChemmolreprsmilesModel, f : Double) -> ChemmolreprsmilesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_add(a : ChemmolreprsmilesModel, b : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_model_copy(s : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_fill(s : ChemmolreprsmilesModel, v : Double) -> ChemmolreprsmilesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_min(s : ChemmolreprsmilesModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_model_max(s : ChemmolreprsmilesModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_model_to_string(s : ChemmolreprsmilesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_layer_make(size : Int) -> ChemmolreprsmilesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_layer_len(s : ChemmolreprsmilesLayer) -> Int { s.size }

pub fn chem_mol_repr_smiles_layer_get(s : ChemmolreprsmilesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_layer_set(s : ChemmolreprsmilesLayer, i : Int, v : Double) -> ChemmolreprsmilesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_sum(s : ChemmolreprsmilesLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_layer_mean(s : ChemmolreprsmilesLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_layer_scale(s : ChemmolreprsmilesLayer, f : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_add(a : ChemmolreprsmilesLayer, b : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_layer_copy(s : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_fill(s : ChemmolreprsmilesLayer, v : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_min(s : ChemmolreprsmilesLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_layer_max(s : ChemmolreprsmilesLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_layer_to_string(s : ChemmolreprsmilesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_buffer_make(size : Int) -> ChemmolreprsmilesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_buffer_len(s : ChemmolreprsmilesBuffer) -> Int { s.size }

pub fn chem_mol_repr_smiles_buffer_get(s : ChemmolreprsmilesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_buffer_set(s : ChemmolreprsmilesBuffer, i : Int, v : Double) -> ChemmolreprsmilesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_sum(s : ChemmolreprsmilesBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_buffer_mean(s : ChemmolreprsmilesBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_buffer_scale(s : ChemmolreprsmilesBuffer, f : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_add(a : ChemmolreprsmilesBuffer, b : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_buffer_copy(s : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_fill(s : ChemmolreprsmilesBuffer, v : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_min(s : ChemmolreprsmilesBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_buffer_max(s : ChemmolreprsmilesBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_buffer_to_string(s : ChemmolreprsmilesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cursor_make(size : Int) -> ChemmolreprsmilesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_cursor_len(s : ChemmolreprsmilesCursor) -> Int { s.size }

pub fn chem_mol_repr_smiles_cursor_get(s : ChemmolreprsmilesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_cursor_set(s : ChemmolreprsmilesCursor, i : Int, v : Double) -> ChemmolreprsmilesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_sum(s : ChemmolreprsmilesCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_cursor_mean(s : ChemmolreprsmilesCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_cursor_scale(s : ChemmolreprsmilesCursor, f : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_add(a : ChemmolreprsmilesCursor, b : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_cursor_copy(s : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_fill(s : ChemmolreprsmilesCursor, v : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_min(s : ChemmolreprsmilesCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_cursor_max(s : ChemmolreprsmilesCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_cursor_to_string(s : ChemmolreprsmilesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_view_make(size : Int) -> ChemmolreprsmilesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_view_len(s : ChemmolreprsmilesView) -> Int { s.size }

pub fn chem_mol_repr_smiles_view_get(s : ChemmolreprsmilesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_view_set(s : ChemmolreprsmilesView, i : Int, v : Double) -> ChemmolreprsmilesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_sum(s : ChemmolreprsmilesView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_view_mean(s : ChemmolreprsmilesView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_view_scale(s : ChemmolreprsmilesView, f : Double) -> ChemmolreprsmilesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_add(a : ChemmolreprsmilesView, b : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_view_copy(s : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_fill(s : ChemmolreprsmilesView, v : Double) -> ChemmolreprsmilesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_min(s : ChemmolreprsmilesView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_view_max(s : ChemmolreprsmilesView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_view_to_string(s : ChemmolreprsmilesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_range_make(size : Int) -> ChemmolreprsmilesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_range_len(s : ChemmolreprsmilesRange) -> Int { s.size }

pub fn chem_mol_repr_smiles_range_get(s : ChemmolreprsmilesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_range_set(s : ChemmolreprsmilesRange, i : Int, v : Double) -> ChemmolreprsmilesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_sum(s : ChemmolreprsmilesRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_range_mean(s : ChemmolreprsmilesRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_range_scale(s : ChemmolreprsmilesRange, f : Double) -> ChemmolreprsmilesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_add(a : ChemmolreprsmilesRange, b : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_range_copy(s : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_fill(s : ChemmolreprsmilesRange, v : Double) -> ChemmolreprsmilesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_min(s : ChemmolreprsmilesRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_range_max(s : ChemmolreprsmilesRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_range_to_string(s : ChemmolreprsmilesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_slice_make(size : Int) -> ChemmolreprsmilesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_slice_len(s : ChemmolreprsmilesSlice) -> Int { s.size }

pub fn chem_mol_repr_smiles_slice_get(s : ChemmolreprsmilesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_slice_set(s : ChemmolreprsmilesSlice, i : Int, v : Double) -> ChemmolreprsmilesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_sum(s : ChemmolreprsmilesSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_slice_mean(s : ChemmolreprsmilesSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_slice_scale(s : ChemmolreprsmilesSlice, f : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_add(a : ChemmolreprsmilesSlice, b : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_slice_copy(s : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_fill(s : ChemmolreprsmilesSlice, v : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_min(s : ChemmolreprsmilesSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_slice_max(s : ChemmolreprsmilesSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_slice_to_string(s : ChemmolreprsmilesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

