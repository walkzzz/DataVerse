///===
/// extcore/ds_hash_cuckoo

pub(all) struct DshashcuckooPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_cuckoo_make_point(x : Double, y : Double) -> DshashcuckooPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_cuckoo_make_point3(x : Double, y : Double, z : Double) -> DshashcuckooPoint {
  { x, y, z, label: 0 }
}

pub fn DshashcuckooPoint::x(self : DshashcuckooPoint) -> Double { self.x }

pub fn DshashcuckooPoint::y(self : DshashcuckooPoint) -> Double { self.y }

pub fn DshashcuckooPoint::z(self : DshashcuckooPoint) -> Double { self.z }

pub fn DshashcuckooPoint::label(self : DshashcuckooPoint) -> Int { self.label }

pub fn DshashcuckooPoint::dist(self : DshashcuckooPoint, other : DshashcuckooPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashcuckooPoint::add(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashcuckooPoint::sub(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashcuckooPoint::scale(self : DshashcuckooPoint, s : Double) -> DshashcuckooPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashcuckooPoint::dot(self : DshashcuckooPoint, other : DshashcuckooPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashcuckooPoint::cross(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashcuckooPoint::norm(self : DshashcuckooPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashcuckooPoint::normalize(self : DshashcuckooPoint) -> DshashcuckooPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashcuckooPoint::negate(self : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashcuckooPoint::mid(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashcuckooPoint::lerp(self : DshashcuckooPoint, other : DshashcuckooPoint, t : Double) -> DshashcuckooPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashcuckooPoint::to_string(self : DshashcuckooPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashcuckooSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_cuckoo_make_series(vals : Array[Double], name : String) -> DshashcuckooSeries {
  { vals, name, meta: 0 }
}

pub fn DshashcuckooSeries::len(self : DshashcuckooSeries) -> Int { self.vals.length() }

pub fn DshashcuckooSeries::sum(self : DshashcuckooSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashcuckooSeries::mean(self : DshashcuckooSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashcuckooSeries::min(self : DshashcuckooSeries) -> Double { @_common.min(self.vals) }

pub fn DshashcuckooSeries::max(self : DshashcuckooSeries) -> Double { @_common.max(self.vals) }

pub fn DshashcuckooSeries::range(self : DshashcuckooSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashcuckooSeries::variance(self : DshashcuckooSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashcuckooSeries::std(self : DshashcuckooSeries) -> Double { @_common.std(self.vals) }

pub fn DshashcuckooSeries::median(self : DshashcuckooSeries) -> Double { @_common.median(self.vals) }

pub fn DshashcuckooSeries::scale(self : DshashcuckooSeries, f : Double) -> DshashcuckooSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashcuckooSeries::add(self : DshashcuckooSeries, other : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashcuckooSeries::sub(self : DshashcuckooSeries, other : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashcuckooSeries::normalize(self : DshashcuckooSeries) -> DshashcuckooSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashcuckooSeries::cumsum(self : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashcuckooSeries::to_string(self : DshashcuckooSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashcuckooMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_cuckoo_make_matrix(rows : Int, cols : Int, val : Double) -> DshashcuckooMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_cuckoo_matrix_identity(n : Int) -> DshashcuckooMatrix {
  let m = ds_hash_cuckoo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashcuckooMatrix::get(self : DshashcuckooMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashcuckooMatrix::transpose(self : DshashcuckooMatrix) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashcuckooMatrix::add(self : DshashcuckooMatrix, other : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_cuckoo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashcuckooMatrix::scale(self : DshashcuckooMatrix, s : Double) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashcuckooMatrix::multiply(self : DshashcuckooMatrix, other : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if self.cols != other.rows { return ds_hash_cuckoo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_cuckoo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashcuckooMatrix::trace(self : DshashcuckooMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashcuckooMatrix::det(self : DshashcuckooMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashcuckooMatrix::norm(self : DshashcuckooMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashcuckooMatrix::to_string(self : DshashcuckooMatrix) -> String {
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

pub(all) struct DshashcuckooVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_cuckoo_make_vector(comps : Array[Double]) -> DshashcuckooVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_cuckoo_vector_zero(dim : Int) -> DshashcuckooVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashcuckooVector::add(self : DshashcuckooVector, other : DshashcuckooVector) -> DshashcuckooVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashcuckooVector::sub(self : DshashcuckooVector, other : DshashcuckooVector) -> DshashcuckooVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashcuckooVector::scale(self : DshashcuckooVector, s : Double) -> DshashcuckooVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashcuckooVector::dot(self : DshashcuckooVector, other : DshashcuckooVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashcuckooVector::norm(self : DshashcuckooVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashcuckooVector::normalize(self : DshashcuckooVector) -> DshashcuckooVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashcuckooVector::dist(self : DshashcuckooVector, other : DshashcuckooVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashcuckooVector::to_string(self : DshashcuckooVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_cuckoo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_cuckoo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_cuckoo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_cuckoo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_cuckoo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_cuckoo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_cuckoo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_cuckoo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_cuckoo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_cuckoo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_cuckoo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_cuckoo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_cuckoo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_cuckoo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_cuckoo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_cuckoo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_cuckoo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_cuckoo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_cuckoo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_cuckoo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_cuckoo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_cuckoo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_cuckoo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_cuckoo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_cuckoo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_cuckoo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_cuckoo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_cuckoo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_cuckoo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashcuckooFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_frame_make(size : Int) -> DshashcuckooFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_frame_len(s : DshashcuckooFrame) -> Int { s.size }

pub fn ds_hash_cuckoo_frame_get(s : DshashcuckooFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_frame_set(s : DshashcuckooFrame, i : Int, v : Double) -> DshashcuckooFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_frame_sum(s : DshashcuckooFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_frame_mean(s : DshashcuckooFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_frame_scale(s : DshashcuckooFrame, f : Double) -> DshashcuckooFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_frame_add(a : DshashcuckooFrame, b : DshashcuckooFrame) -> DshashcuckooFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_frame_copy(s : DshashcuckooFrame) -> DshashcuckooFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_frame_fill(s : DshashcuckooFrame, v : Double) -> DshashcuckooFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_frame_min(s : DshashcuckooFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_frame_max(s : DshashcuckooFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_frame_to_string(s : DshashcuckooFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_table_make(size : Int) -> DshashcuckooTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_table_len(s : DshashcuckooTable) -> Int { s.size }

pub fn ds_hash_cuckoo_table_get(s : DshashcuckooTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_table_set(s : DshashcuckooTable, i : Int, v : Double) -> DshashcuckooTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_table_sum(s : DshashcuckooTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_table_mean(s : DshashcuckooTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_table_scale(s : DshashcuckooTable, f : Double) -> DshashcuckooTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_table_add(a : DshashcuckooTable, b : DshashcuckooTable) -> DshashcuckooTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_table_copy(s : DshashcuckooTable) -> DshashcuckooTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_table_fill(s : DshashcuckooTable, v : Double) -> DshashcuckooTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_table_min(s : DshashcuckooTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_table_max(s : DshashcuckooTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_table_to_string(s : DshashcuckooTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_graphn_make(size : Int) -> DshashcuckooGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_graphn_len(s : DshashcuckooGraphN) -> Int { s.size }

pub fn ds_hash_cuckoo_graphn_get(s : DshashcuckooGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_graphn_set(s : DshashcuckooGraphN, i : Int, v : Double) -> DshashcuckooGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_graphn_sum(s : DshashcuckooGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_graphn_mean(s : DshashcuckooGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_graphn_scale(s : DshashcuckooGraphN, f : Double) -> DshashcuckooGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_graphn_add(a : DshashcuckooGraphN, b : DshashcuckooGraphN) -> DshashcuckooGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_graphn_copy(s : DshashcuckooGraphN) -> DshashcuckooGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_graphn_fill(s : DshashcuckooGraphN, v : Double) -> DshashcuckooGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_graphn_min(s : DshashcuckooGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_graphn_max(s : DshashcuckooGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_graphn_to_string(s : DshashcuckooGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_node_make(size : Int) -> DshashcuckooNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_node_len(s : DshashcuckooNode) -> Int { s.size }

pub fn ds_hash_cuckoo_node_get(s : DshashcuckooNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_node_set(s : DshashcuckooNode, i : Int, v : Double) -> DshashcuckooNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_node_sum(s : DshashcuckooNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_node_mean(s : DshashcuckooNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_node_scale(s : DshashcuckooNode, f : Double) -> DshashcuckooNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_node_add(a : DshashcuckooNode, b : DshashcuckooNode) -> DshashcuckooNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_node_copy(s : DshashcuckooNode) -> DshashcuckooNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_node_fill(s : DshashcuckooNode, v : Double) -> DshashcuckooNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_node_min(s : DshashcuckooNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_node_max(s : DshashcuckooNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_node_to_string(s : DshashcuckooNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_edge_make(size : Int) -> DshashcuckooEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_edge_len(s : DshashcuckooEdge) -> Int { s.size }

pub fn ds_hash_cuckoo_edge_get(s : DshashcuckooEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_edge_set(s : DshashcuckooEdge, i : Int, v : Double) -> DshashcuckooEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_edge_sum(s : DshashcuckooEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_edge_mean(s : DshashcuckooEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_edge_scale(s : DshashcuckooEdge, f : Double) -> DshashcuckooEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_edge_add(a : DshashcuckooEdge, b : DshashcuckooEdge) -> DshashcuckooEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_edge_copy(s : DshashcuckooEdge) -> DshashcuckooEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_edge_fill(s : DshashcuckooEdge, v : Double) -> DshashcuckooEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_edge_min(s : DshashcuckooEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_edge_max(s : DshashcuckooEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_edge_to_string(s : DshashcuckooEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_path_make(size : Int) -> DshashcuckooPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_path_len(s : DshashcuckooPath) -> Int { s.size }

pub fn ds_hash_cuckoo_path_get(s : DshashcuckooPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_path_set(s : DshashcuckooPath, i : Int, v : Double) -> DshashcuckooPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_path_sum(s : DshashcuckooPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_path_mean(s : DshashcuckooPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_path_scale(s : DshashcuckooPath, f : Double) -> DshashcuckooPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_path_add(a : DshashcuckooPath, b : DshashcuckooPath) -> DshashcuckooPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_path_copy(s : DshashcuckooPath) -> DshashcuckooPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_path_fill(s : DshashcuckooPath, v : Double) -> DshashcuckooPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_path_min(s : DshashcuckooPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_path_max(s : DshashcuckooPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_path_to_string(s : DshashcuckooPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cluster_make(size : Int) -> DshashcuckooCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_cluster_len(s : DshashcuckooCluster) -> Int { s.size }

pub fn ds_hash_cuckoo_cluster_get(s : DshashcuckooCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_cluster_set(s : DshashcuckooCluster, i : Int, v : Double) -> DshashcuckooCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cluster_sum(s : DshashcuckooCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_cluster_mean(s : DshashcuckooCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_cluster_scale(s : DshashcuckooCluster, f : Double) -> DshashcuckooCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cluster_add(a : DshashcuckooCluster, b : DshashcuckooCluster) -> DshashcuckooCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_cluster_copy(s : DshashcuckooCluster) -> DshashcuckooCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cluster_fill(s : DshashcuckooCluster, v : Double) -> DshashcuckooCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cluster_min(s : DshashcuckooCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_cluster_max(s : DshashcuckooCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_cluster_to_string(s : DshashcuckooCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_model_make(size : Int) -> DshashcuckooModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_model_len(s : DshashcuckooModel) -> Int { s.size }

pub fn ds_hash_cuckoo_model_get(s : DshashcuckooModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_model_set(s : DshashcuckooModel, i : Int, v : Double) -> DshashcuckooModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_model_sum(s : DshashcuckooModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_model_mean(s : DshashcuckooModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_model_scale(s : DshashcuckooModel, f : Double) -> DshashcuckooModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_model_add(a : DshashcuckooModel, b : DshashcuckooModel) -> DshashcuckooModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_model_copy(s : DshashcuckooModel) -> DshashcuckooModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_model_fill(s : DshashcuckooModel, v : Double) -> DshashcuckooModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_model_min(s : DshashcuckooModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_model_max(s : DshashcuckooModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_model_to_string(s : DshashcuckooModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_layer_make(size : Int) -> DshashcuckooLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_layer_len(s : DshashcuckooLayer) -> Int { s.size }

pub fn ds_hash_cuckoo_layer_get(s : DshashcuckooLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_layer_set(s : DshashcuckooLayer, i : Int, v : Double) -> DshashcuckooLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_layer_sum(s : DshashcuckooLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_layer_mean(s : DshashcuckooLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_layer_scale(s : DshashcuckooLayer, f : Double) -> DshashcuckooLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_layer_add(a : DshashcuckooLayer, b : DshashcuckooLayer) -> DshashcuckooLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_layer_copy(s : DshashcuckooLayer) -> DshashcuckooLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_layer_fill(s : DshashcuckooLayer, v : Double) -> DshashcuckooLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_layer_min(s : DshashcuckooLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_layer_max(s : DshashcuckooLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_layer_to_string(s : DshashcuckooLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_buffer_make(size : Int) -> DshashcuckooBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_buffer_len(s : DshashcuckooBuffer) -> Int { s.size }

pub fn ds_hash_cuckoo_buffer_get(s : DshashcuckooBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_buffer_set(s : DshashcuckooBuffer, i : Int, v : Double) -> DshashcuckooBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_buffer_sum(s : DshashcuckooBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_buffer_mean(s : DshashcuckooBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_buffer_scale(s : DshashcuckooBuffer, f : Double) -> DshashcuckooBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_buffer_add(a : DshashcuckooBuffer, b : DshashcuckooBuffer) -> DshashcuckooBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_buffer_copy(s : DshashcuckooBuffer) -> DshashcuckooBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_buffer_fill(s : DshashcuckooBuffer, v : Double) -> DshashcuckooBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_buffer_min(s : DshashcuckooBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_buffer_max(s : DshashcuckooBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_buffer_to_string(s : DshashcuckooBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cursor_make(size : Int) -> DshashcuckooCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_cursor_len(s : DshashcuckooCursor) -> Int { s.size }

pub fn ds_hash_cuckoo_cursor_get(s : DshashcuckooCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_cursor_set(s : DshashcuckooCursor, i : Int, v : Double) -> DshashcuckooCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cursor_sum(s : DshashcuckooCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_cursor_mean(s : DshashcuckooCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_cursor_scale(s : DshashcuckooCursor, f : Double) -> DshashcuckooCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cursor_add(a : DshashcuckooCursor, b : DshashcuckooCursor) -> DshashcuckooCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_cursor_copy(s : DshashcuckooCursor) -> DshashcuckooCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cursor_fill(s : DshashcuckooCursor, v : Double) -> DshashcuckooCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_cursor_min(s : DshashcuckooCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_cursor_max(s : DshashcuckooCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_cursor_to_string(s : DshashcuckooCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_view_make(size : Int) -> DshashcuckooView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_view_len(s : DshashcuckooView) -> Int { s.size }

pub fn ds_hash_cuckoo_view_get(s : DshashcuckooView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_view_set(s : DshashcuckooView, i : Int, v : Double) -> DshashcuckooView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_view_sum(s : DshashcuckooView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_view_mean(s : DshashcuckooView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_view_scale(s : DshashcuckooView, f : Double) -> DshashcuckooView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_view_add(a : DshashcuckooView, b : DshashcuckooView) -> DshashcuckooView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_view_copy(s : DshashcuckooView) -> DshashcuckooView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_view_fill(s : DshashcuckooView, v : Double) -> DshashcuckooView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_view_min(s : DshashcuckooView) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_view_max(s : DshashcuckooView) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_view_to_string(s : DshashcuckooView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_range_make(size : Int) -> DshashcuckooRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_range_len(s : DshashcuckooRange) -> Int { s.size }

pub fn ds_hash_cuckoo_range_get(s : DshashcuckooRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_range_set(s : DshashcuckooRange, i : Int, v : Double) -> DshashcuckooRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_range_sum(s : DshashcuckooRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_range_mean(s : DshashcuckooRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_range_scale(s : DshashcuckooRange, f : Double) -> DshashcuckooRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_range_add(a : DshashcuckooRange, b : DshashcuckooRange) -> DshashcuckooRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_range_copy(s : DshashcuckooRange) -> DshashcuckooRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_range_fill(s : DshashcuckooRange, v : Double) -> DshashcuckooRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_range_min(s : DshashcuckooRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_range_max(s : DshashcuckooRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_range_to_string(s : DshashcuckooRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_slice_make(size : Int) -> DshashcuckooSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_slice_len(s : DshashcuckooSlice) -> Int { s.size }

pub fn ds_hash_cuckoo_slice_get(s : DshashcuckooSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_slice_set(s : DshashcuckooSlice, i : Int, v : Double) -> DshashcuckooSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_slice_sum(s : DshashcuckooSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_cuckoo_slice_mean(s : DshashcuckooSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_cuckoo_slice_scale(s : DshashcuckooSlice, f : Double) -> DshashcuckooSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_slice_add(a : DshashcuckooSlice, b : DshashcuckooSlice) -> DshashcuckooSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_cuckoo_slice_copy(s : DshashcuckooSlice) -> DshashcuckooSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_slice_fill(s : DshashcuckooSlice, v : Double) -> DshashcuckooSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_cuckoo_slice_min(s : DshashcuckooSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_cuckoo_slice_max(s : DshashcuckooSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_cuckoo_slice_to_string(s : DshashcuckooSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

