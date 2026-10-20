///===
/// extcore/ml_cluster_optics

pub(all) struct MlclusteropticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_optics_make_point(x : Double, y : Double) -> MlclusteropticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_optics_make_point3(x : Double, y : Double, z : Double) -> MlclusteropticsPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusteropticsPoint::x(self : MlclusteropticsPoint) -> Double { self.x }

pub fn MlclusteropticsPoint::y(self : MlclusteropticsPoint) -> Double { self.y }

pub fn MlclusteropticsPoint::z(self : MlclusteropticsPoint) -> Double { self.z }

pub fn MlclusteropticsPoint::label(self : MlclusteropticsPoint) -> Int { self.label }

pub fn MlclusteropticsPoint::dist(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusteropticsPoint::add(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusteropticsPoint::sub(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusteropticsPoint::scale(self : MlclusteropticsPoint, s : Double) -> MlclusteropticsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusteropticsPoint::dot(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusteropticsPoint::cross(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusteropticsPoint::norm(self : MlclusteropticsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusteropticsPoint::normalize(self : MlclusteropticsPoint) -> MlclusteropticsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteropticsPoint::negate(self : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusteropticsPoint::mid(self : MlclusteropticsPoint, other : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusteropticsPoint::lerp(self : MlclusteropticsPoint, other : MlclusteropticsPoint, t : Double) -> MlclusteropticsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusteropticsPoint::to_string(self : MlclusteropticsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusteropticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_optics_make_series(vals : Array[Double], name : String) -> MlclusteropticsSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusteropticsSeries::len(self : MlclusteropticsSeries) -> Int { self.vals.length() }

pub fn MlclusteropticsSeries::sum(self : MlclusteropticsSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusteropticsSeries::mean(self : MlclusteropticsSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusteropticsSeries::min(self : MlclusteropticsSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusteropticsSeries::max(self : MlclusteropticsSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusteropticsSeries::range(self : MlclusteropticsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusteropticsSeries::variance(self : MlclusteropticsSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusteropticsSeries::std(self : MlclusteropticsSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusteropticsSeries::median(self : MlclusteropticsSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusteropticsSeries::scale(self : MlclusteropticsSeries, f : Double) -> MlclusteropticsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::add(self : MlclusteropticsSeries, other : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::sub(self : MlclusteropticsSeries, other : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusteropticsSeries::normalize(self : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusteropticsSeries::cumsum(self : MlclusteropticsSeries) -> MlclusteropticsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusteropticsSeries::to_string(self : MlclusteropticsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteropticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_optics_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteropticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_optics_matrix_identity(n : Int) -> MlclusteropticsMatrix {
  let m = ml_cluster_optics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusteropticsMatrix::get(self : MlclusteropticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusteropticsMatrix::transpose(self : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusteropticsMatrix::add(self : MlclusteropticsMatrix, other : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_optics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusteropticsMatrix::scale(self : MlclusteropticsMatrix, s : Double) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusteropticsMatrix::multiply(self : MlclusteropticsMatrix, other : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if self.cols != other.rows { return ml_cluster_optics_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_optics_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusteropticsMatrix::trace(self : MlclusteropticsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusteropticsMatrix::det(self : MlclusteropticsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusteropticsMatrix::norm(self : MlclusteropticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusteropticsMatrix::to_string(self : MlclusteropticsMatrix) -> String {
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

pub(all) struct MlclusteropticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_optics_make_vector(comps : Array[Double]) -> MlclusteropticsVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_optics_vector_zero(dim : Int) -> MlclusteropticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusteropticsVector::add(self : MlclusteropticsVector, other : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteropticsVector::sub(self : MlclusteropticsVector, other : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteropticsVector::scale(self : MlclusteropticsVector, s : Double) -> MlclusteropticsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusteropticsVector::dot(self : MlclusteropticsVector, other : MlclusteropticsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusteropticsVector::norm(self : MlclusteropticsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusteropticsVector::normalize(self : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteropticsVector::dist(self : MlclusteropticsVector, other : MlclusteropticsVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusteropticsVector::to_string(self : MlclusteropticsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_optics_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_optics_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_optics_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_optics_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_optics_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_optics_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_optics_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_optics_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_optics_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_optics_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_optics_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_optics_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_optics_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_optics_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_optics_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_optics_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_optics_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_optics_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_optics_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_optics_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_optics_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_optics_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_optics_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_optics_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_optics_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_optics_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_optics_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_optics_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_optics_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusteropticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_frame_make(size : Int) -> MlclusteropticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_frame_len(s : MlclusteropticsFrame) -> Int { s.size }

pub fn ml_cluster_optics_frame_get(s : MlclusteropticsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_frame_set(s : MlclusteropticsFrame, i : Int, v : Double) -> MlclusteropticsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_frame_sum(s : MlclusteropticsFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_frame_mean(s : MlclusteropticsFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_frame_scale(s : MlclusteropticsFrame, f : Double) -> MlclusteropticsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_frame_add(a : MlclusteropticsFrame, b : MlclusteropticsFrame) -> MlclusteropticsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_frame_copy(s : MlclusteropticsFrame) -> MlclusteropticsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_frame_fill(s : MlclusteropticsFrame, v : Double) -> MlclusteropticsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_frame_min(s : MlclusteropticsFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_frame_max(s : MlclusteropticsFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_frame_to_string(s : MlclusteropticsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_table_make(size : Int) -> MlclusteropticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_table_len(s : MlclusteropticsTable) -> Int { s.size }

pub fn ml_cluster_optics_table_get(s : MlclusteropticsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_table_set(s : MlclusteropticsTable, i : Int, v : Double) -> MlclusteropticsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_table_sum(s : MlclusteropticsTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_table_mean(s : MlclusteropticsTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_table_scale(s : MlclusteropticsTable, f : Double) -> MlclusteropticsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_table_add(a : MlclusteropticsTable, b : MlclusteropticsTable) -> MlclusteropticsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_table_copy(s : MlclusteropticsTable) -> MlclusteropticsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_table_fill(s : MlclusteropticsTable, v : Double) -> MlclusteropticsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_table_min(s : MlclusteropticsTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_table_max(s : MlclusteropticsTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_table_to_string(s : MlclusteropticsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_graphn_make(size : Int) -> MlclusteropticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_graphn_len(s : MlclusteropticsGraphN) -> Int { s.size }

pub fn ml_cluster_optics_graphn_get(s : MlclusteropticsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_graphn_set(s : MlclusteropticsGraphN, i : Int, v : Double) -> MlclusteropticsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_graphn_sum(s : MlclusteropticsGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_graphn_mean(s : MlclusteropticsGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_graphn_scale(s : MlclusteropticsGraphN, f : Double) -> MlclusteropticsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_graphn_add(a : MlclusteropticsGraphN, b : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_graphn_copy(s : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_graphn_fill(s : MlclusteropticsGraphN, v : Double) -> MlclusteropticsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_graphn_min(s : MlclusteropticsGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_graphn_max(s : MlclusteropticsGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_graphn_to_string(s : MlclusteropticsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_node_make(size : Int) -> MlclusteropticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_node_len(s : MlclusteropticsNode) -> Int { s.size }

pub fn ml_cluster_optics_node_get(s : MlclusteropticsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_node_set(s : MlclusteropticsNode, i : Int, v : Double) -> MlclusteropticsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_node_sum(s : MlclusteropticsNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_node_mean(s : MlclusteropticsNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_node_scale(s : MlclusteropticsNode, f : Double) -> MlclusteropticsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_node_add(a : MlclusteropticsNode, b : MlclusteropticsNode) -> MlclusteropticsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_node_copy(s : MlclusteropticsNode) -> MlclusteropticsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_node_fill(s : MlclusteropticsNode, v : Double) -> MlclusteropticsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_node_min(s : MlclusteropticsNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_node_max(s : MlclusteropticsNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_node_to_string(s : MlclusteropticsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_edge_make(size : Int) -> MlclusteropticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_edge_len(s : MlclusteropticsEdge) -> Int { s.size }

pub fn ml_cluster_optics_edge_get(s : MlclusteropticsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_edge_set(s : MlclusteropticsEdge, i : Int, v : Double) -> MlclusteropticsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_edge_sum(s : MlclusteropticsEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_edge_mean(s : MlclusteropticsEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_edge_scale(s : MlclusteropticsEdge, f : Double) -> MlclusteropticsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_edge_add(a : MlclusteropticsEdge, b : MlclusteropticsEdge) -> MlclusteropticsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_edge_copy(s : MlclusteropticsEdge) -> MlclusteropticsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_edge_fill(s : MlclusteropticsEdge, v : Double) -> MlclusteropticsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_edge_min(s : MlclusteropticsEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_edge_max(s : MlclusteropticsEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_edge_to_string(s : MlclusteropticsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_path_make(size : Int) -> MlclusteropticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_path_len(s : MlclusteropticsPath) -> Int { s.size }

pub fn ml_cluster_optics_path_get(s : MlclusteropticsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_path_set(s : MlclusteropticsPath, i : Int, v : Double) -> MlclusteropticsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_path_sum(s : MlclusteropticsPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_path_mean(s : MlclusteropticsPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_path_scale(s : MlclusteropticsPath, f : Double) -> MlclusteropticsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_path_add(a : MlclusteropticsPath, b : MlclusteropticsPath) -> MlclusteropticsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_path_copy(s : MlclusteropticsPath) -> MlclusteropticsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_path_fill(s : MlclusteropticsPath, v : Double) -> MlclusteropticsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_path_min(s : MlclusteropticsPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_path_max(s : MlclusteropticsPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_path_to_string(s : MlclusteropticsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cluster_make(size : Int) -> MlclusteropticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_cluster_len(s : MlclusteropticsCluster) -> Int { s.size }

pub fn ml_cluster_optics_cluster_get(s : MlclusteropticsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_cluster_set(s : MlclusteropticsCluster, i : Int, v : Double) -> MlclusteropticsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cluster_sum(s : MlclusteropticsCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_cluster_mean(s : MlclusteropticsCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_cluster_scale(s : MlclusteropticsCluster, f : Double) -> MlclusteropticsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cluster_add(a : MlclusteropticsCluster, b : MlclusteropticsCluster) -> MlclusteropticsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_cluster_copy(s : MlclusteropticsCluster) -> MlclusteropticsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cluster_fill(s : MlclusteropticsCluster, v : Double) -> MlclusteropticsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cluster_min(s : MlclusteropticsCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_cluster_max(s : MlclusteropticsCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_cluster_to_string(s : MlclusteropticsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_model_make(size : Int) -> MlclusteropticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_model_len(s : MlclusteropticsModel) -> Int { s.size }

pub fn ml_cluster_optics_model_get(s : MlclusteropticsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_model_set(s : MlclusteropticsModel, i : Int, v : Double) -> MlclusteropticsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_model_sum(s : MlclusteropticsModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_model_mean(s : MlclusteropticsModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_model_scale(s : MlclusteropticsModel, f : Double) -> MlclusteropticsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_model_add(a : MlclusteropticsModel, b : MlclusteropticsModel) -> MlclusteropticsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_model_copy(s : MlclusteropticsModel) -> MlclusteropticsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_model_fill(s : MlclusteropticsModel, v : Double) -> MlclusteropticsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_model_min(s : MlclusteropticsModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_model_max(s : MlclusteropticsModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_model_to_string(s : MlclusteropticsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_layer_make(size : Int) -> MlclusteropticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_layer_len(s : MlclusteropticsLayer) -> Int { s.size }

pub fn ml_cluster_optics_layer_get(s : MlclusteropticsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_layer_set(s : MlclusteropticsLayer, i : Int, v : Double) -> MlclusteropticsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_layer_sum(s : MlclusteropticsLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_layer_mean(s : MlclusteropticsLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_layer_scale(s : MlclusteropticsLayer, f : Double) -> MlclusteropticsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_layer_add(a : MlclusteropticsLayer, b : MlclusteropticsLayer) -> MlclusteropticsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_layer_copy(s : MlclusteropticsLayer) -> MlclusteropticsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_layer_fill(s : MlclusteropticsLayer, v : Double) -> MlclusteropticsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_layer_min(s : MlclusteropticsLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_layer_max(s : MlclusteropticsLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_layer_to_string(s : MlclusteropticsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_buffer_make(size : Int) -> MlclusteropticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_buffer_len(s : MlclusteropticsBuffer) -> Int { s.size }

pub fn ml_cluster_optics_buffer_get(s : MlclusteropticsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_buffer_set(s : MlclusteropticsBuffer, i : Int, v : Double) -> MlclusteropticsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_buffer_sum(s : MlclusteropticsBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_buffer_mean(s : MlclusteropticsBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_buffer_scale(s : MlclusteropticsBuffer, f : Double) -> MlclusteropticsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_buffer_add(a : MlclusteropticsBuffer, b : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_buffer_copy(s : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_buffer_fill(s : MlclusteropticsBuffer, v : Double) -> MlclusteropticsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_buffer_min(s : MlclusteropticsBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_buffer_max(s : MlclusteropticsBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_buffer_to_string(s : MlclusteropticsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cursor_make(size : Int) -> MlclusteropticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_cursor_len(s : MlclusteropticsCursor) -> Int { s.size }

pub fn ml_cluster_optics_cursor_get(s : MlclusteropticsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_cursor_set(s : MlclusteropticsCursor, i : Int, v : Double) -> MlclusteropticsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cursor_sum(s : MlclusteropticsCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_cursor_mean(s : MlclusteropticsCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_cursor_scale(s : MlclusteropticsCursor, f : Double) -> MlclusteropticsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cursor_add(a : MlclusteropticsCursor, b : MlclusteropticsCursor) -> MlclusteropticsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_cursor_copy(s : MlclusteropticsCursor) -> MlclusteropticsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cursor_fill(s : MlclusteropticsCursor, v : Double) -> MlclusteropticsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_cursor_min(s : MlclusteropticsCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_cursor_max(s : MlclusteropticsCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_cursor_to_string(s : MlclusteropticsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_view_make(size : Int) -> MlclusteropticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_view_len(s : MlclusteropticsView) -> Int { s.size }

pub fn ml_cluster_optics_view_get(s : MlclusteropticsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_view_set(s : MlclusteropticsView, i : Int, v : Double) -> MlclusteropticsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_view_sum(s : MlclusteropticsView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_view_mean(s : MlclusteropticsView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_view_scale(s : MlclusteropticsView, f : Double) -> MlclusteropticsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_view_add(a : MlclusteropticsView, b : MlclusteropticsView) -> MlclusteropticsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_view_copy(s : MlclusteropticsView) -> MlclusteropticsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_view_fill(s : MlclusteropticsView, v : Double) -> MlclusteropticsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_view_min(s : MlclusteropticsView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_view_max(s : MlclusteropticsView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_view_to_string(s : MlclusteropticsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_range_make(size : Int) -> MlclusteropticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_range_len(s : MlclusteropticsRange) -> Int { s.size }

pub fn ml_cluster_optics_range_get(s : MlclusteropticsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_range_set(s : MlclusteropticsRange, i : Int, v : Double) -> MlclusteropticsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_range_sum(s : MlclusteropticsRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_range_mean(s : MlclusteropticsRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_range_scale(s : MlclusteropticsRange, f : Double) -> MlclusteropticsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_range_add(a : MlclusteropticsRange, b : MlclusteropticsRange) -> MlclusteropticsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_range_copy(s : MlclusteropticsRange) -> MlclusteropticsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_range_fill(s : MlclusteropticsRange, v : Double) -> MlclusteropticsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_range_min(s : MlclusteropticsRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_range_max(s : MlclusteropticsRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_range_to_string(s : MlclusteropticsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_slice_make(size : Int) -> MlclusteropticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_slice_len(s : MlclusteropticsSlice) -> Int { s.size }

pub fn ml_cluster_optics_slice_get(s : MlclusteropticsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_slice_set(s : MlclusteropticsSlice, i : Int, v : Double) -> MlclusteropticsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_slice_sum(s : MlclusteropticsSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_optics_slice_mean(s : MlclusteropticsSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_optics_slice_scale(s : MlclusteropticsSlice, f : Double) -> MlclusteropticsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_slice_add(a : MlclusteropticsSlice, b : MlclusteropticsSlice) -> MlclusteropticsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_optics_slice_copy(s : MlclusteropticsSlice) -> MlclusteropticsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_slice_fill(s : MlclusteropticsSlice, v : Double) -> MlclusteropticsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_optics_slice_min(s : MlclusteropticsSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_optics_slice_max(s : MlclusteropticsSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_optics_slice_to_string(s : MlclusteropticsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

