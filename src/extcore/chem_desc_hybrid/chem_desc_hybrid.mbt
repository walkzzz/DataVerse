///===
/// extcore/chem_desc_hybrid

pub(all) struct ChemdeschybridPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_hybrid_make_point(x : Double, y : Double) -> ChemdeschybridPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_hybrid_make_point3(x : Double, y : Double, z : Double) -> ChemdeschybridPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdeschybridPoint::x(self : ChemdeschybridPoint) -> Double { self.x }

pub fn ChemdeschybridPoint::y(self : ChemdeschybridPoint) -> Double { self.y }

pub fn ChemdeschybridPoint::z(self : ChemdeschybridPoint) -> Double { self.z }

pub fn ChemdeschybridPoint::label(self : ChemdeschybridPoint) -> Int { self.label }

pub fn ChemdeschybridPoint::dist(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdeschybridPoint::add(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdeschybridPoint::sub(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdeschybridPoint::scale(self : ChemdeschybridPoint, s : Double) -> ChemdeschybridPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdeschybridPoint::dot(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdeschybridPoint::cross(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdeschybridPoint::norm(self : ChemdeschybridPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdeschybridPoint::normalize(self : ChemdeschybridPoint) -> ChemdeschybridPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdeschybridPoint::negate(self : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdeschybridPoint::mid(self : ChemdeschybridPoint, other : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdeschybridPoint::lerp(self : ChemdeschybridPoint, other : ChemdeschybridPoint, t : Double) -> ChemdeschybridPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdeschybridPoint::to_string(self : ChemdeschybridPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdeschybridSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_hybrid_make_series(vals : Array[Double], name : String) -> ChemdeschybridSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdeschybridSeries::len(self : ChemdeschybridSeries) -> Int { self.vals.length() }

pub fn ChemdeschybridSeries::sum(self : ChemdeschybridSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdeschybridSeries::mean(self : ChemdeschybridSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdeschybridSeries::min(self : ChemdeschybridSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdeschybridSeries::max(self : ChemdeschybridSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdeschybridSeries::range(self : ChemdeschybridSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdeschybridSeries::variance(self : ChemdeschybridSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdeschybridSeries::std(self : ChemdeschybridSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdeschybridSeries::median(self : ChemdeschybridSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdeschybridSeries::scale(self : ChemdeschybridSeries, f : Double) -> ChemdeschybridSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdeschybridSeries::add(self : ChemdeschybridSeries, other : ChemdeschybridSeries) -> ChemdeschybridSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdeschybridSeries::sub(self : ChemdeschybridSeries, other : ChemdeschybridSeries) -> ChemdeschybridSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdeschybridSeries::normalize(self : ChemdeschybridSeries) -> ChemdeschybridSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdeschybridSeries::cumsum(self : ChemdeschybridSeries) -> ChemdeschybridSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdeschybridSeries::to_string(self : ChemdeschybridSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdeschybridMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_hybrid_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdeschybridMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_hybrid_matrix_identity(n : Int) -> ChemdeschybridMatrix {
  let m = chem_desc_hybrid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdeschybridMatrix::get(self : ChemdeschybridMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdeschybridMatrix::transpose(self : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdeschybridMatrix::add(self : ChemdeschybridMatrix, other : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdeschybridMatrix::scale(self : ChemdeschybridMatrix, s : Double) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdeschybridMatrix::multiply(self : ChemdeschybridMatrix, other : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  if self.cols != other.rows { return chem_desc_hybrid_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_hybrid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdeschybridMatrix::trace(self : ChemdeschybridMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdeschybridMatrix::det(self : ChemdeschybridMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdeschybridMatrix::norm(self : ChemdeschybridMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdeschybridMatrix::to_string(self : ChemdeschybridMatrix) -> String {
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

pub(all) struct ChemdeschybridVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_hybrid_make_vector(comps : Array[Double]) -> ChemdeschybridVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_hybrid_vector_zero(dim : Int) -> ChemdeschybridVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdeschybridVector::add(self : ChemdeschybridVector, other : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdeschybridVector::sub(self : ChemdeschybridVector, other : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdeschybridVector::scale(self : ChemdeschybridVector, s : Double) -> ChemdeschybridVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdeschybridVector::dot(self : ChemdeschybridVector, other : ChemdeschybridVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdeschybridVector::norm(self : ChemdeschybridVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdeschybridVector::normalize(self : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdeschybridVector::dist(self : ChemdeschybridVector, other : ChemdeschybridVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdeschybridVector::to_string(self : ChemdeschybridVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_hybrid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_hybrid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_hybrid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_hybrid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_hybrid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_hybrid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_hybrid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_hybrid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_hybrid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_hybrid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_hybrid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_hybrid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_hybrid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_hybrid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_hybrid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_hybrid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_hybrid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_hybrid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_hybrid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_hybrid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_hybrid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_hybrid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_hybrid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_hybrid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_hybrid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_hybrid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_hybrid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_hybrid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_hybrid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdeschybridFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_frame_make(size : Int) -> ChemdeschybridFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_frame_len(s : ChemdeschybridFrame) -> Int { s.size }

pub fn chem_desc_hybrid_frame_get(s : ChemdeschybridFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_frame_set(s : ChemdeschybridFrame, i : Int, v : Double) -> ChemdeschybridFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_frame_sum(s : ChemdeschybridFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_frame_mean(s : ChemdeschybridFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_frame_scale(s : ChemdeschybridFrame, f : Double) -> ChemdeschybridFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_frame_add(a : ChemdeschybridFrame, b : ChemdeschybridFrame) -> ChemdeschybridFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_frame_copy(s : ChemdeschybridFrame) -> ChemdeschybridFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_frame_fill(s : ChemdeschybridFrame, v : Double) -> ChemdeschybridFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_frame_min(s : ChemdeschybridFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_frame_max(s : ChemdeschybridFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_frame_to_string(s : ChemdeschybridFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_table_make(size : Int) -> ChemdeschybridTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_table_len(s : ChemdeschybridTable) -> Int { s.size }

pub fn chem_desc_hybrid_table_get(s : ChemdeschybridTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_table_set(s : ChemdeschybridTable, i : Int, v : Double) -> ChemdeschybridTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_table_sum(s : ChemdeschybridTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_table_mean(s : ChemdeschybridTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_table_scale(s : ChemdeschybridTable, f : Double) -> ChemdeschybridTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_table_add(a : ChemdeschybridTable, b : ChemdeschybridTable) -> ChemdeschybridTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_table_copy(s : ChemdeschybridTable) -> ChemdeschybridTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_table_fill(s : ChemdeschybridTable, v : Double) -> ChemdeschybridTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_table_min(s : ChemdeschybridTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_table_max(s : ChemdeschybridTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_table_to_string(s : ChemdeschybridTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_graphn_make(size : Int) -> ChemdeschybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_graphn_len(s : ChemdeschybridGraphN) -> Int { s.size }

pub fn chem_desc_hybrid_graphn_get(s : ChemdeschybridGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_graphn_set(s : ChemdeschybridGraphN, i : Int, v : Double) -> ChemdeschybridGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_graphn_sum(s : ChemdeschybridGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_graphn_mean(s : ChemdeschybridGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_graphn_scale(s : ChemdeschybridGraphN, f : Double) -> ChemdeschybridGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_graphn_add(a : ChemdeschybridGraphN, b : ChemdeschybridGraphN) -> ChemdeschybridGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_graphn_copy(s : ChemdeschybridGraphN) -> ChemdeschybridGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_graphn_fill(s : ChemdeschybridGraphN, v : Double) -> ChemdeschybridGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_graphn_min(s : ChemdeschybridGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_graphn_max(s : ChemdeschybridGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_graphn_to_string(s : ChemdeschybridGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_node_make(size : Int) -> ChemdeschybridNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_node_len(s : ChemdeschybridNode) -> Int { s.size }

pub fn chem_desc_hybrid_node_get(s : ChemdeschybridNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_node_set(s : ChemdeschybridNode, i : Int, v : Double) -> ChemdeschybridNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_node_sum(s : ChemdeschybridNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_node_mean(s : ChemdeschybridNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_node_scale(s : ChemdeschybridNode, f : Double) -> ChemdeschybridNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_node_add(a : ChemdeschybridNode, b : ChemdeschybridNode) -> ChemdeschybridNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_node_copy(s : ChemdeschybridNode) -> ChemdeschybridNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_node_fill(s : ChemdeschybridNode, v : Double) -> ChemdeschybridNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_node_min(s : ChemdeschybridNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_node_max(s : ChemdeschybridNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_node_to_string(s : ChemdeschybridNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_edge_make(size : Int) -> ChemdeschybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_edge_len(s : ChemdeschybridEdge) -> Int { s.size }

pub fn chem_desc_hybrid_edge_get(s : ChemdeschybridEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_edge_set(s : ChemdeschybridEdge, i : Int, v : Double) -> ChemdeschybridEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_edge_sum(s : ChemdeschybridEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_edge_mean(s : ChemdeschybridEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_edge_scale(s : ChemdeschybridEdge, f : Double) -> ChemdeschybridEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_edge_add(a : ChemdeschybridEdge, b : ChemdeschybridEdge) -> ChemdeschybridEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_edge_copy(s : ChemdeschybridEdge) -> ChemdeschybridEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_edge_fill(s : ChemdeschybridEdge, v : Double) -> ChemdeschybridEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_edge_min(s : ChemdeschybridEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_edge_max(s : ChemdeschybridEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_edge_to_string(s : ChemdeschybridEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_path_make(size : Int) -> ChemdeschybridPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_path_len(s : ChemdeschybridPath) -> Int { s.size }

pub fn chem_desc_hybrid_path_get(s : ChemdeschybridPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_path_set(s : ChemdeschybridPath, i : Int, v : Double) -> ChemdeschybridPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_path_sum(s : ChemdeschybridPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_path_mean(s : ChemdeschybridPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_path_scale(s : ChemdeschybridPath, f : Double) -> ChemdeschybridPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_path_add(a : ChemdeschybridPath, b : ChemdeschybridPath) -> ChemdeschybridPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_path_copy(s : ChemdeschybridPath) -> ChemdeschybridPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_path_fill(s : ChemdeschybridPath, v : Double) -> ChemdeschybridPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_path_min(s : ChemdeschybridPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_path_max(s : ChemdeschybridPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_path_to_string(s : ChemdeschybridPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_cluster_make(size : Int) -> ChemdeschybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_cluster_len(s : ChemdeschybridCluster) -> Int { s.size }

pub fn chem_desc_hybrid_cluster_get(s : ChemdeschybridCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_cluster_set(s : ChemdeschybridCluster, i : Int, v : Double) -> ChemdeschybridCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cluster_sum(s : ChemdeschybridCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_cluster_mean(s : ChemdeschybridCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_cluster_scale(s : ChemdeschybridCluster, f : Double) -> ChemdeschybridCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cluster_add(a : ChemdeschybridCluster, b : ChemdeschybridCluster) -> ChemdeschybridCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_cluster_copy(s : ChemdeschybridCluster) -> ChemdeschybridCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cluster_fill(s : ChemdeschybridCluster, v : Double) -> ChemdeschybridCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cluster_min(s : ChemdeschybridCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_cluster_max(s : ChemdeschybridCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_cluster_to_string(s : ChemdeschybridCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_model_make(size : Int) -> ChemdeschybridModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_model_len(s : ChemdeschybridModel) -> Int { s.size }

pub fn chem_desc_hybrid_model_get(s : ChemdeschybridModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_model_set(s : ChemdeschybridModel, i : Int, v : Double) -> ChemdeschybridModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_model_sum(s : ChemdeschybridModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_model_mean(s : ChemdeschybridModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_model_scale(s : ChemdeschybridModel, f : Double) -> ChemdeschybridModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_model_add(a : ChemdeschybridModel, b : ChemdeschybridModel) -> ChemdeschybridModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_model_copy(s : ChemdeschybridModel) -> ChemdeschybridModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_model_fill(s : ChemdeschybridModel, v : Double) -> ChemdeschybridModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_model_min(s : ChemdeschybridModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_model_max(s : ChemdeschybridModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_model_to_string(s : ChemdeschybridModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_layer_make(size : Int) -> ChemdeschybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_layer_len(s : ChemdeschybridLayer) -> Int { s.size }

pub fn chem_desc_hybrid_layer_get(s : ChemdeschybridLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_layer_set(s : ChemdeschybridLayer, i : Int, v : Double) -> ChemdeschybridLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_layer_sum(s : ChemdeschybridLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_layer_mean(s : ChemdeschybridLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_layer_scale(s : ChemdeschybridLayer, f : Double) -> ChemdeschybridLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_layer_add(a : ChemdeschybridLayer, b : ChemdeschybridLayer) -> ChemdeschybridLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_layer_copy(s : ChemdeschybridLayer) -> ChemdeschybridLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_layer_fill(s : ChemdeschybridLayer, v : Double) -> ChemdeschybridLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_layer_min(s : ChemdeschybridLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_layer_max(s : ChemdeschybridLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_layer_to_string(s : ChemdeschybridLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_buffer_make(size : Int) -> ChemdeschybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_buffer_len(s : ChemdeschybridBuffer) -> Int { s.size }

pub fn chem_desc_hybrid_buffer_get(s : ChemdeschybridBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_buffer_set(s : ChemdeschybridBuffer, i : Int, v : Double) -> ChemdeschybridBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_buffer_sum(s : ChemdeschybridBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_buffer_mean(s : ChemdeschybridBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_buffer_scale(s : ChemdeschybridBuffer, f : Double) -> ChemdeschybridBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_buffer_add(a : ChemdeschybridBuffer, b : ChemdeschybridBuffer) -> ChemdeschybridBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_buffer_copy(s : ChemdeschybridBuffer) -> ChemdeschybridBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_buffer_fill(s : ChemdeschybridBuffer, v : Double) -> ChemdeschybridBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_buffer_min(s : ChemdeschybridBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_buffer_max(s : ChemdeschybridBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_buffer_to_string(s : ChemdeschybridBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_cursor_make(size : Int) -> ChemdeschybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_cursor_len(s : ChemdeschybridCursor) -> Int { s.size }

pub fn chem_desc_hybrid_cursor_get(s : ChemdeschybridCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_cursor_set(s : ChemdeschybridCursor, i : Int, v : Double) -> ChemdeschybridCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cursor_sum(s : ChemdeschybridCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_cursor_mean(s : ChemdeschybridCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_cursor_scale(s : ChemdeschybridCursor, f : Double) -> ChemdeschybridCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cursor_add(a : ChemdeschybridCursor, b : ChemdeschybridCursor) -> ChemdeschybridCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_cursor_copy(s : ChemdeschybridCursor) -> ChemdeschybridCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cursor_fill(s : ChemdeschybridCursor, v : Double) -> ChemdeschybridCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_cursor_min(s : ChemdeschybridCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_cursor_max(s : ChemdeschybridCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_cursor_to_string(s : ChemdeschybridCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_view_make(size : Int) -> ChemdeschybridView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_view_len(s : ChemdeschybridView) -> Int { s.size }

pub fn chem_desc_hybrid_view_get(s : ChemdeschybridView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_view_set(s : ChemdeschybridView, i : Int, v : Double) -> ChemdeschybridView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_view_sum(s : ChemdeschybridView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_view_mean(s : ChemdeschybridView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_view_scale(s : ChemdeschybridView, f : Double) -> ChemdeschybridView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_view_add(a : ChemdeschybridView, b : ChemdeschybridView) -> ChemdeschybridView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_view_copy(s : ChemdeschybridView) -> ChemdeschybridView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_view_fill(s : ChemdeschybridView, v : Double) -> ChemdeschybridView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_view_min(s : ChemdeschybridView) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_view_max(s : ChemdeschybridView) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_view_to_string(s : ChemdeschybridView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_range_make(size : Int) -> ChemdeschybridRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_range_len(s : ChemdeschybridRange) -> Int { s.size }

pub fn chem_desc_hybrid_range_get(s : ChemdeschybridRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_range_set(s : ChemdeschybridRange, i : Int, v : Double) -> ChemdeschybridRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_range_sum(s : ChemdeschybridRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_range_mean(s : ChemdeschybridRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_range_scale(s : ChemdeschybridRange, f : Double) -> ChemdeschybridRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_range_add(a : ChemdeschybridRange, b : ChemdeschybridRange) -> ChemdeschybridRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_range_copy(s : ChemdeschybridRange) -> ChemdeschybridRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_range_fill(s : ChemdeschybridRange, v : Double) -> ChemdeschybridRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_range_min(s : ChemdeschybridRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_range_max(s : ChemdeschybridRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_range_to_string(s : ChemdeschybridRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_slice_make(size : Int) -> ChemdeschybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_slice_len(s : ChemdeschybridSlice) -> Int { s.size }

pub fn chem_desc_hybrid_slice_get(s : ChemdeschybridSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_slice_set(s : ChemdeschybridSlice, i : Int, v : Double) -> ChemdeschybridSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_slice_sum(s : ChemdeschybridSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_hybrid_slice_mean(s : ChemdeschybridSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_hybrid_slice_scale(s : ChemdeschybridSlice, f : Double) -> ChemdeschybridSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_slice_add(a : ChemdeschybridSlice, b : ChemdeschybridSlice) -> ChemdeschybridSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_hybrid_slice_copy(s : ChemdeschybridSlice) -> ChemdeschybridSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_slice_fill(s : ChemdeschybridSlice, v : Double) -> ChemdeschybridSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_hybrid_slice_min(s : ChemdeschybridSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_hybrid_slice_max(s : ChemdeschybridSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_hybrid_slice_to_string(s : ChemdeschybridSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

