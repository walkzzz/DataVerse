///===
/// extcore/chem_mol_repr_sdf

pub(all) struct ChemmolreprsdfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_sdf_make_point(x : Double, y : Double) -> ChemmolreprsdfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_sdf_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsdfPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprsdfPoint::x(self : ChemmolreprsdfPoint) -> Double { self.x }

pub fn ChemmolreprsdfPoint::y(self : ChemmolreprsdfPoint) -> Double { self.y }

pub fn ChemmolreprsdfPoint::z(self : ChemmolreprsdfPoint) -> Double { self.z }

pub fn ChemmolreprsdfPoint::label(self : ChemmolreprsdfPoint) -> Int { self.label }

pub fn ChemmolreprsdfPoint::dist(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprsdfPoint::add(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::sub(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::scale(self : ChemmolreprsdfPoint, s : Double) -> ChemmolreprsdfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprsdfPoint::dot(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprsdfPoint::cross(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprsdfPoint::norm(self : ChemmolreprsdfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprsdfPoint::normalize(self : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsdfPoint::negate(self : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprsdfPoint::mid(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprsdfPoint::lerp(self : ChemmolreprsdfPoint, other : ChemmolreprsdfPoint, t : Double) -> ChemmolreprsdfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprsdfPoint::to_string(self : ChemmolreprsdfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_sdf_make_series(vals : Array[Double], name : String) -> ChemmolreprsdfSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprsdfSeries::len(self : ChemmolreprsdfSeries) -> Int { self.vals.length() }

pub fn ChemmolreprsdfSeries::sum(self : ChemmolreprsdfSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprsdfSeries::mean(self : ChemmolreprsdfSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprsdfSeries::min(self : ChemmolreprsdfSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprsdfSeries::max(self : ChemmolreprsdfSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprsdfSeries::range(self : ChemmolreprsdfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprsdfSeries::variance(self : ChemmolreprsdfSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprsdfSeries::std(self : ChemmolreprsdfSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprsdfSeries::median(self : ChemmolreprsdfSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprsdfSeries::scale(self : ChemmolreprsdfSeries, f : Double) -> ChemmolreprsdfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::add(self : ChemmolreprsdfSeries, other : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::sub(self : ChemmolreprsdfSeries, other : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprsdfSeries::normalize(self : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprsdfSeries::cumsum(self : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprsdfSeries::to_string(self : ChemmolreprsdfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsdfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_sdf_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsdfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_sdf_matrix_identity(n : Int) -> ChemmolreprsdfMatrix {
  let m = chem_mol_repr_sdf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprsdfMatrix::get(self : ChemmolreprsdfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprsdfMatrix::transpose(self : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprsdfMatrix::add(self : ChemmolreprsdfMatrix, other : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_sdf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprsdfMatrix::scale(self : ChemmolreprsdfMatrix, s : Double) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprsdfMatrix::multiply(self : ChemmolreprsdfMatrix, other : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if self.cols != other.rows { return chem_mol_repr_sdf_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_sdf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprsdfMatrix::trace(self : ChemmolreprsdfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprsdfMatrix::det(self : ChemmolreprsdfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprsdfMatrix::norm(self : ChemmolreprsdfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprsdfMatrix::to_string(self : ChemmolreprsdfMatrix) -> String {
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

pub(all) struct ChemmolreprsdfVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_sdf_make_vector(comps : Array[Double]) -> ChemmolreprsdfVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_sdf_vector_zero(dim : Int) -> ChemmolreprsdfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprsdfVector::add(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsdfVector::sub(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsdfVector::scale(self : ChemmolreprsdfVector, s : Double) -> ChemmolreprsdfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprsdfVector::dot(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprsdfVector::norm(self : ChemmolreprsdfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprsdfVector::normalize(self : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsdfVector::dist(self : ChemmolreprsdfVector, other : ChemmolreprsdfVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprsdfVector::to_string(self : ChemmolreprsdfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_sdf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_sdf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_sdf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_sdf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_sdf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_sdf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_sdf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_sdf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_sdf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_sdf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_sdf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_sdf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_sdf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_sdf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_sdf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_sdf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_sdf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_sdf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_sdf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_sdf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_sdf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_sdf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_sdf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_sdf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_sdf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_sdf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_sdf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_sdf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_sdf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprsdfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_frame_make(size : Int) -> ChemmolreprsdfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_frame_len(s : ChemmolreprsdfFrame) -> Int { s.size }

pub fn chem_mol_repr_sdf_frame_get(s : ChemmolreprsdfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_frame_set(s : ChemmolreprsdfFrame, i : Int, v : Double) -> ChemmolreprsdfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_frame_sum(s : ChemmolreprsdfFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_frame_mean(s : ChemmolreprsdfFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_frame_scale(s : ChemmolreprsdfFrame, f : Double) -> ChemmolreprsdfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_frame_add(a : ChemmolreprsdfFrame, b : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_frame_copy(s : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_frame_fill(s : ChemmolreprsdfFrame, v : Double) -> ChemmolreprsdfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_frame_min(s : ChemmolreprsdfFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_frame_max(s : ChemmolreprsdfFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_frame_to_string(s : ChemmolreprsdfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_table_make(size : Int) -> ChemmolreprsdfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_table_len(s : ChemmolreprsdfTable) -> Int { s.size }

pub fn chem_mol_repr_sdf_table_get(s : ChemmolreprsdfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_table_set(s : ChemmolreprsdfTable, i : Int, v : Double) -> ChemmolreprsdfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_table_sum(s : ChemmolreprsdfTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_table_mean(s : ChemmolreprsdfTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_table_scale(s : ChemmolreprsdfTable, f : Double) -> ChemmolreprsdfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_table_add(a : ChemmolreprsdfTable, b : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_table_copy(s : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_table_fill(s : ChemmolreprsdfTable, v : Double) -> ChemmolreprsdfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_table_min(s : ChemmolreprsdfTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_table_max(s : ChemmolreprsdfTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_table_to_string(s : ChemmolreprsdfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_graphn_make(size : Int) -> ChemmolreprsdfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_graphn_len(s : ChemmolreprsdfGraphN) -> Int { s.size }

pub fn chem_mol_repr_sdf_graphn_get(s : ChemmolreprsdfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_graphn_set(s : ChemmolreprsdfGraphN, i : Int, v : Double) -> ChemmolreprsdfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_graphn_sum(s : ChemmolreprsdfGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_graphn_mean(s : ChemmolreprsdfGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_graphn_scale(s : ChemmolreprsdfGraphN, f : Double) -> ChemmolreprsdfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_graphn_add(a : ChemmolreprsdfGraphN, b : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_graphn_copy(s : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_graphn_fill(s : ChemmolreprsdfGraphN, v : Double) -> ChemmolreprsdfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_graphn_min(s : ChemmolreprsdfGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_graphn_max(s : ChemmolreprsdfGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_graphn_to_string(s : ChemmolreprsdfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_node_make(size : Int) -> ChemmolreprsdfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_node_len(s : ChemmolreprsdfNode) -> Int { s.size }

pub fn chem_mol_repr_sdf_node_get(s : ChemmolreprsdfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_node_set(s : ChemmolreprsdfNode, i : Int, v : Double) -> ChemmolreprsdfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_node_sum(s : ChemmolreprsdfNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_node_mean(s : ChemmolreprsdfNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_node_scale(s : ChemmolreprsdfNode, f : Double) -> ChemmolreprsdfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_node_add(a : ChemmolreprsdfNode, b : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_node_copy(s : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_node_fill(s : ChemmolreprsdfNode, v : Double) -> ChemmolreprsdfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_node_min(s : ChemmolreprsdfNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_node_max(s : ChemmolreprsdfNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_node_to_string(s : ChemmolreprsdfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_edge_make(size : Int) -> ChemmolreprsdfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_edge_len(s : ChemmolreprsdfEdge) -> Int { s.size }

pub fn chem_mol_repr_sdf_edge_get(s : ChemmolreprsdfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_edge_set(s : ChemmolreprsdfEdge, i : Int, v : Double) -> ChemmolreprsdfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_edge_sum(s : ChemmolreprsdfEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_edge_mean(s : ChemmolreprsdfEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_edge_scale(s : ChemmolreprsdfEdge, f : Double) -> ChemmolreprsdfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_edge_add(a : ChemmolreprsdfEdge, b : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_edge_copy(s : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_edge_fill(s : ChemmolreprsdfEdge, v : Double) -> ChemmolreprsdfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_edge_min(s : ChemmolreprsdfEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_edge_max(s : ChemmolreprsdfEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_edge_to_string(s : ChemmolreprsdfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_path_make(size : Int) -> ChemmolreprsdfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_path_len(s : ChemmolreprsdfPath) -> Int { s.size }

pub fn chem_mol_repr_sdf_path_get(s : ChemmolreprsdfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_path_set(s : ChemmolreprsdfPath, i : Int, v : Double) -> ChemmolreprsdfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_path_sum(s : ChemmolreprsdfPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_path_mean(s : ChemmolreprsdfPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_path_scale(s : ChemmolreprsdfPath, f : Double) -> ChemmolreprsdfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_path_add(a : ChemmolreprsdfPath, b : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_path_copy(s : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_path_fill(s : ChemmolreprsdfPath, v : Double) -> ChemmolreprsdfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_path_min(s : ChemmolreprsdfPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_path_max(s : ChemmolreprsdfPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_path_to_string(s : ChemmolreprsdfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cluster_make(size : Int) -> ChemmolreprsdfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_cluster_len(s : ChemmolreprsdfCluster) -> Int { s.size }

pub fn chem_mol_repr_sdf_cluster_get(s : ChemmolreprsdfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_cluster_set(s : ChemmolreprsdfCluster, i : Int, v : Double) -> ChemmolreprsdfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cluster_sum(s : ChemmolreprsdfCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_cluster_mean(s : ChemmolreprsdfCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_cluster_scale(s : ChemmolreprsdfCluster, f : Double) -> ChemmolreprsdfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cluster_add(a : ChemmolreprsdfCluster, b : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_cluster_copy(s : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cluster_fill(s : ChemmolreprsdfCluster, v : Double) -> ChemmolreprsdfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cluster_min(s : ChemmolreprsdfCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_cluster_max(s : ChemmolreprsdfCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_cluster_to_string(s : ChemmolreprsdfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_model_make(size : Int) -> ChemmolreprsdfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_model_len(s : ChemmolreprsdfModel) -> Int { s.size }

pub fn chem_mol_repr_sdf_model_get(s : ChemmolreprsdfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_model_set(s : ChemmolreprsdfModel, i : Int, v : Double) -> ChemmolreprsdfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_model_sum(s : ChemmolreprsdfModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_model_mean(s : ChemmolreprsdfModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_model_scale(s : ChemmolreprsdfModel, f : Double) -> ChemmolreprsdfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_model_add(a : ChemmolreprsdfModel, b : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_model_copy(s : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_model_fill(s : ChemmolreprsdfModel, v : Double) -> ChemmolreprsdfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_model_min(s : ChemmolreprsdfModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_model_max(s : ChemmolreprsdfModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_model_to_string(s : ChemmolreprsdfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_layer_make(size : Int) -> ChemmolreprsdfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_layer_len(s : ChemmolreprsdfLayer) -> Int { s.size }

pub fn chem_mol_repr_sdf_layer_get(s : ChemmolreprsdfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_layer_set(s : ChemmolreprsdfLayer, i : Int, v : Double) -> ChemmolreprsdfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_layer_sum(s : ChemmolreprsdfLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_layer_mean(s : ChemmolreprsdfLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_layer_scale(s : ChemmolreprsdfLayer, f : Double) -> ChemmolreprsdfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_layer_add(a : ChemmolreprsdfLayer, b : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_layer_copy(s : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_layer_fill(s : ChemmolreprsdfLayer, v : Double) -> ChemmolreprsdfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_layer_min(s : ChemmolreprsdfLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_layer_max(s : ChemmolreprsdfLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_layer_to_string(s : ChemmolreprsdfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_buffer_make(size : Int) -> ChemmolreprsdfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_buffer_len(s : ChemmolreprsdfBuffer) -> Int { s.size }

pub fn chem_mol_repr_sdf_buffer_get(s : ChemmolreprsdfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_buffer_set(s : ChemmolreprsdfBuffer, i : Int, v : Double) -> ChemmolreprsdfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_buffer_sum(s : ChemmolreprsdfBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_buffer_mean(s : ChemmolreprsdfBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_buffer_scale(s : ChemmolreprsdfBuffer, f : Double) -> ChemmolreprsdfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_buffer_add(a : ChemmolreprsdfBuffer, b : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_buffer_copy(s : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_buffer_fill(s : ChemmolreprsdfBuffer, v : Double) -> ChemmolreprsdfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_buffer_min(s : ChemmolreprsdfBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_buffer_max(s : ChemmolreprsdfBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_buffer_to_string(s : ChemmolreprsdfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cursor_make(size : Int) -> ChemmolreprsdfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_cursor_len(s : ChemmolreprsdfCursor) -> Int { s.size }

pub fn chem_mol_repr_sdf_cursor_get(s : ChemmolreprsdfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_cursor_set(s : ChemmolreprsdfCursor, i : Int, v : Double) -> ChemmolreprsdfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cursor_sum(s : ChemmolreprsdfCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_cursor_mean(s : ChemmolreprsdfCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_cursor_scale(s : ChemmolreprsdfCursor, f : Double) -> ChemmolreprsdfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cursor_add(a : ChemmolreprsdfCursor, b : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_cursor_copy(s : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cursor_fill(s : ChemmolreprsdfCursor, v : Double) -> ChemmolreprsdfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_cursor_min(s : ChemmolreprsdfCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_cursor_max(s : ChemmolreprsdfCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_cursor_to_string(s : ChemmolreprsdfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_view_make(size : Int) -> ChemmolreprsdfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_view_len(s : ChemmolreprsdfView) -> Int { s.size }

pub fn chem_mol_repr_sdf_view_get(s : ChemmolreprsdfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_view_set(s : ChemmolreprsdfView, i : Int, v : Double) -> ChemmolreprsdfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_view_sum(s : ChemmolreprsdfView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_view_mean(s : ChemmolreprsdfView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_view_scale(s : ChemmolreprsdfView, f : Double) -> ChemmolreprsdfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_view_add(a : ChemmolreprsdfView, b : ChemmolreprsdfView) -> ChemmolreprsdfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_view_copy(s : ChemmolreprsdfView) -> ChemmolreprsdfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_view_fill(s : ChemmolreprsdfView, v : Double) -> ChemmolreprsdfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_view_min(s : ChemmolreprsdfView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_view_max(s : ChemmolreprsdfView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_view_to_string(s : ChemmolreprsdfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_range_make(size : Int) -> ChemmolreprsdfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_range_len(s : ChemmolreprsdfRange) -> Int { s.size }

pub fn chem_mol_repr_sdf_range_get(s : ChemmolreprsdfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_range_set(s : ChemmolreprsdfRange, i : Int, v : Double) -> ChemmolreprsdfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_range_sum(s : ChemmolreprsdfRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_range_mean(s : ChemmolreprsdfRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_range_scale(s : ChemmolreprsdfRange, f : Double) -> ChemmolreprsdfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_range_add(a : ChemmolreprsdfRange, b : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_range_copy(s : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_range_fill(s : ChemmolreprsdfRange, v : Double) -> ChemmolreprsdfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_range_min(s : ChemmolreprsdfRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_range_max(s : ChemmolreprsdfRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_range_to_string(s : ChemmolreprsdfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_slice_make(size : Int) -> ChemmolreprsdfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_slice_len(s : ChemmolreprsdfSlice) -> Int { s.size }

pub fn chem_mol_repr_sdf_slice_get(s : ChemmolreprsdfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_slice_set(s : ChemmolreprsdfSlice, i : Int, v : Double) -> ChemmolreprsdfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_slice_sum(s : ChemmolreprsdfSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_sdf_slice_mean(s : ChemmolreprsdfSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_sdf_slice_scale(s : ChemmolreprsdfSlice, f : Double) -> ChemmolreprsdfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_slice_add(a : ChemmolreprsdfSlice, b : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_sdf_slice_copy(s : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_slice_fill(s : ChemmolreprsdfSlice, v : Double) -> ChemmolreprsdfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_sdf_slice_min(s : ChemmolreprsdfSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_sdf_slice_max(s : ChemmolreprsdfSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_sdf_slice_to_string(s : ChemmolreprsdfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

