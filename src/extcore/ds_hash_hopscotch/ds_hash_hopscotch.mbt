///===
/// extcore/ds_hash_hopscotch

pub(all) struct DshashhopscotchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_hopscotch_make_point(x : Double, y : Double) -> DshashhopscotchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_hopscotch_make_point3(x : Double, y : Double, z : Double) -> DshashhopscotchPoint {
  { x, y, z, label: 0 }
}

pub fn DshashhopscotchPoint::x(self : DshashhopscotchPoint) -> Double { self.x }

pub fn DshashhopscotchPoint::y(self : DshashhopscotchPoint) -> Double { self.y }

pub fn DshashhopscotchPoint::z(self : DshashhopscotchPoint) -> Double { self.z }

pub fn DshashhopscotchPoint::label(self : DshashhopscotchPoint) -> Int { self.label }

pub fn DshashhopscotchPoint::dist(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashhopscotchPoint::add(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashhopscotchPoint::sub(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashhopscotchPoint::scale(self : DshashhopscotchPoint, s : Double) -> DshashhopscotchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashhopscotchPoint::dot(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashhopscotchPoint::cross(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashhopscotchPoint::norm(self : DshashhopscotchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashhopscotchPoint::normalize(self : DshashhopscotchPoint) -> DshashhopscotchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashhopscotchPoint::negate(self : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashhopscotchPoint::mid(self : DshashhopscotchPoint, other : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashhopscotchPoint::lerp(self : DshashhopscotchPoint, other : DshashhopscotchPoint, t : Double) -> DshashhopscotchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashhopscotchPoint::to_string(self : DshashhopscotchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashhopscotchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_hopscotch_make_series(vals : Array[Double], name : String) -> DshashhopscotchSeries {
  { vals, name, meta: 0 }
}

pub fn DshashhopscotchSeries::len(self : DshashhopscotchSeries) -> Int { self.vals.length() }

pub fn DshashhopscotchSeries::sum(self : DshashhopscotchSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashhopscotchSeries::mean(self : DshashhopscotchSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashhopscotchSeries::min(self : DshashhopscotchSeries) -> Double { @_common.min(self.vals) }

pub fn DshashhopscotchSeries::max(self : DshashhopscotchSeries) -> Double { @_common.max(self.vals) }

pub fn DshashhopscotchSeries::range(self : DshashhopscotchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashhopscotchSeries::variance(self : DshashhopscotchSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashhopscotchSeries::std(self : DshashhopscotchSeries) -> Double { @_common.std(self.vals) }

pub fn DshashhopscotchSeries::median(self : DshashhopscotchSeries) -> Double { @_common.median(self.vals) }

pub fn DshashhopscotchSeries::scale(self : DshashhopscotchSeries, f : Double) -> DshashhopscotchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashhopscotchSeries::add(self : DshashhopscotchSeries, other : DshashhopscotchSeries) -> DshashhopscotchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashhopscotchSeries::sub(self : DshashhopscotchSeries, other : DshashhopscotchSeries) -> DshashhopscotchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashhopscotchSeries::normalize(self : DshashhopscotchSeries) -> DshashhopscotchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashhopscotchSeries::cumsum(self : DshashhopscotchSeries) -> DshashhopscotchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashhopscotchSeries::to_string(self : DshashhopscotchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashhopscotchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_hopscotch_make_matrix(rows : Int, cols : Int, val : Double) -> DshashhopscotchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_hopscotch_matrix_identity(n : Int) -> DshashhopscotchMatrix {
  let m = ds_hash_hopscotch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashhopscotchMatrix::get(self : DshashhopscotchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashhopscotchMatrix::transpose(self : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashhopscotchMatrix::add(self : DshashhopscotchMatrix, other : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_hopscotch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashhopscotchMatrix::scale(self : DshashhopscotchMatrix, s : Double) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashhopscotchMatrix::multiply(self : DshashhopscotchMatrix, other : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  if self.cols != other.rows { return ds_hash_hopscotch_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_hopscotch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashhopscotchMatrix::trace(self : DshashhopscotchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashhopscotchMatrix::det(self : DshashhopscotchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashhopscotchMatrix::norm(self : DshashhopscotchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashhopscotchMatrix::to_string(self : DshashhopscotchMatrix) -> String {
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

pub(all) struct DshashhopscotchVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_hopscotch_make_vector(comps : Array[Double]) -> DshashhopscotchVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_hopscotch_vector_zero(dim : Int) -> DshashhopscotchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashhopscotchVector::add(self : DshashhopscotchVector, other : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashhopscotchVector::sub(self : DshashhopscotchVector, other : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashhopscotchVector::scale(self : DshashhopscotchVector, s : Double) -> DshashhopscotchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashhopscotchVector::dot(self : DshashhopscotchVector, other : DshashhopscotchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashhopscotchVector::norm(self : DshashhopscotchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashhopscotchVector::normalize(self : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashhopscotchVector::dist(self : DshashhopscotchVector, other : DshashhopscotchVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashhopscotchVector::to_string(self : DshashhopscotchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_hopscotch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_hopscotch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_hopscotch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_hopscotch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_hopscotch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_hopscotch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_hopscotch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_hopscotch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_hopscotch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_hopscotch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_hopscotch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_hopscotch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_hopscotch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_hopscotch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_hopscotch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_hopscotch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_hopscotch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_hopscotch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_hopscotch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_hopscotch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_hopscotch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_hopscotch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_hopscotch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_hopscotch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_hopscotch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_hopscotch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_hopscotch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_hopscotch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_hopscotch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashhopscotchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_frame_make(size : Int) -> DshashhopscotchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_frame_len(s : DshashhopscotchFrame) -> Int { s.size }

pub fn ds_hash_hopscotch_frame_get(s : DshashhopscotchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_frame_set(s : DshashhopscotchFrame, i : Int, v : Double) -> DshashhopscotchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_frame_sum(s : DshashhopscotchFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_frame_mean(s : DshashhopscotchFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_frame_scale(s : DshashhopscotchFrame, f : Double) -> DshashhopscotchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_frame_add(a : DshashhopscotchFrame, b : DshashhopscotchFrame) -> DshashhopscotchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_frame_copy(s : DshashhopscotchFrame) -> DshashhopscotchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_frame_fill(s : DshashhopscotchFrame, v : Double) -> DshashhopscotchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_frame_min(s : DshashhopscotchFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_frame_max(s : DshashhopscotchFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_frame_to_string(s : DshashhopscotchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_table_make(size : Int) -> DshashhopscotchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_table_len(s : DshashhopscotchTable) -> Int { s.size }

pub fn ds_hash_hopscotch_table_get(s : DshashhopscotchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_table_set(s : DshashhopscotchTable, i : Int, v : Double) -> DshashhopscotchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_table_sum(s : DshashhopscotchTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_table_mean(s : DshashhopscotchTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_table_scale(s : DshashhopscotchTable, f : Double) -> DshashhopscotchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_table_add(a : DshashhopscotchTable, b : DshashhopscotchTable) -> DshashhopscotchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_table_copy(s : DshashhopscotchTable) -> DshashhopscotchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_table_fill(s : DshashhopscotchTable, v : Double) -> DshashhopscotchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_table_min(s : DshashhopscotchTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_table_max(s : DshashhopscotchTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_table_to_string(s : DshashhopscotchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_graphn_make(size : Int) -> DshashhopscotchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_graphn_len(s : DshashhopscotchGraphN) -> Int { s.size }

pub fn ds_hash_hopscotch_graphn_get(s : DshashhopscotchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_graphn_set(s : DshashhopscotchGraphN, i : Int, v : Double) -> DshashhopscotchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_graphn_sum(s : DshashhopscotchGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_graphn_mean(s : DshashhopscotchGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_graphn_scale(s : DshashhopscotchGraphN, f : Double) -> DshashhopscotchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_graphn_add(a : DshashhopscotchGraphN, b : DshashhopscotchGraphN) -> DshashhopscotchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_graphn_copy(s : DshashhopscotchGraphN) -> DshashhopscotchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_graphn_fill(s : DshashhopscotchGraphN, v : Double) -> DshashhopscotchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_graphn_min(s : DshashhopscotchGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_graphn_max(s : DshashhopscotchGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_graphn_to_string(s : DshashhopscotchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_node_make(size : Int) -> DshashhopscotchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_node_len(s : DshashhopscotchNode) -> Int { s.size }

pub fn ds_hash_hopscotch_node_get(s : DshashhopscotchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_node_set(s : DshashhopscotchNode, i : Int, v : Double) -> DshashhopscotchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_node_sum(s : DshashhopscotchNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_node_mean(s : DshashhopscotchNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_node_scale(s : DshashhopscotchNode, f : Double) -> DshashhopscotchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_node_add(a : DshashhopscotchNode, b : DshashhopscotchNode) -> DshashhopscotchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_node_copy(s : DshashhopscotchNode) -> DshashhopscotchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_node_fill(s : DshashhopscotchNode, v : Double) -> DshashhopscotchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_node_min(s : DshashhopscotchNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_node_max(s : DshashhopscotchNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_node_to_string(s : DshashhopscotchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_edge_make(size : Int) -> DshashhopscotchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_edge_len(s : DshashhopscotchEdge) -> Int { s.size }

pub fn ds_hash_hopscotch_edge_get(s : DshashhopscotchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_edge_set(s : DshashhopscotchEdge, i : Int, v : Double) -> DshashhopscotchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_edge_sum(s : DshashhopscotchEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_edge_mean(s : DshashhopscotchEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_edge_scale(s : DshashhopscotchEdge, f : Double) -> DshashhopscotchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_edge_add(a : DshashhopscotchEdge, b : DshashhopscotchEdge) -> DshashhopscotchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_edge_copy(s : DshashhopscotchEdge) -> DshashhopscotchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_edge_fill(s : DshashhopscotchEdge, v : Double) -> DshashhopscotchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_edge_min(s : DshashhopscotchEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_edge_max(s : DshashhopscotchEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_edge_to_string(s : DshashhopscotchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_path_make(size : Int) -> DshashhopscotchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_path_len(s : DshashhopscotchPath) -> Int { s.size }

pub fn ds_hash_hopscotch_path_get(s : DshashhopscotchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_path_set(s : DshashhopscotchPath, i : Int, v : Double) -> DshashhopscotchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_path_sum(s : DshashhopscotchPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_path_mean(s : DshashhopscotchPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_path_scale(s : DshashhopscotchPath, f : Double) -> DshashhopscotchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_path_add(a : DshashhopscotchPath, b : DshashhopscotchPath) -> DshashhopscotchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_path_copy(s : DshashhopscotchPath) -> DshashhopscotchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_path_fill(s : DshashhopscotchPath, v : Double) -> DshashhopscotchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_path_min(s : DshashhopscotchPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_path_max(s : DshashhopscotchPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_path_to_string(s : DshashhopscotchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_cluster_make(size : Int) -> DshashhopscotchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_cluster_len(s : DshashhopscotchCluster) -> Int { s.size }

pub fn ds_hash_hopscotch_cluster_get(s : DshashhopscotchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_cluster_set(s : DshashhopscotchCluster, i : Int, v : Double) -> DshashhopscotchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cluster_sum(s : DshashhopscotchCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_cluster_mean(s : DshashhopscotchCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_cluster_scale(s : DshashhopscotchCluster, f : Double) -> DshashhopscotchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cluster_add(a : DshashhopscotchCluster, b : DshashhopscotchCluster) -> DshashhopscotchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_cluster_copy(s : DshashhopscotchCluster) -> DshashhopscotchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cluster_fill(s : DshashhopscotchCluster, v : Double) -> DshashhopscotchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cluster_min(s : DshashhopscotchCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_cluster_max(s : DshashhopscotchCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_cluster_to_string(s : DshashhopscotchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_model_make(size : Int) -> DshashhopscotchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_model_len(s : DshashhopscotchModel) -> Int { s.size }

pub fn ds_hash_hopscotch_model_get(s : DshashhopscotchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_model_set(s : DshashhopscotchModel, i : Int, v : Double) -> DshashhopscotchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_model_sum(s : DshashhopscotchModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_model_mean(s : DshashhopscotchModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_model_scale(s : DshashhopscotchModel, f : Double) -> DshashhopscotchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_model_add(a : DshashhopscotchModel, b : DshashhopscotchModel) -> DshashhopscotchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_model_copy(s : DshashhopscotchModel) -> DshashhopscotchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_model_fill(s : DshashhopscotchModel, v : Double) -> DshashhopscotchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_model_min(s : DshashhopscotchModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_model_max(s : DshashhopscotchModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_model_to_string(s : DshashhopscotchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_layer_make(size : Int) -> DshashhopscotchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_layer_len(s : DshashhopscotchLayer) -> Int { s.size }

pub fn ds_hash_hopscotch_layer_get(s : DshashhopscotchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_layer_set(s : DshashhopscotchLayer, i : Int, v : Double) -> DshashhopscotchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_layer_sum(s : DshashhopscotchLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_layer_mean(s : DshashhopscotchLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_layer_scale(s : DshashhopscotchLayer, f : Double) -> DshashhopscotchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_layer_add(a : DshashhopscotchLayer, b : DshashhopscotchLayer) -> DshashhopscotchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_layer_copy(s : DshashhopscotchLayer) -> DshashhopscotchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_layer_fill(s : DshashhopscotchLayer, v : Double) -> DshashhopscotchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_layer_min(s : DshashhopscotchLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_layer_max(s : DshashhopscotchLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_layer_to_string(s : DshashhopscotchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_buffer_make(size : Int) -> DshashhopscotchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_buffer_len(s : DshashhopscotchBuffer) -> Int { s.size }

pub fn ds_hash_hopscotch_buffer_get(s : DshashhopscotchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_buffer_set(s : DshashhopscotchBuffer, i : Int, v : Double) -> DshashhopscotchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_buffer_sum(s : DshashhopscotchBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_buffer_mean(s : DshashhopscotchBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_buffer_scale(s : DshashhopscotchBuffer, f : Double) -> DshashhopscotchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_buffer_add(a : DshashhopscotchBuffer, b : DshashhopscotchBuffer) -> DshashhopscotchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_buffer_copy(s : DshashhopscotchBuffer) -> DshashhopscotchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_buffer_fill(s : DshashhopscotchBuffer, v : Double) -> DshashhopscotchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_buffer_min(s : DshashhopscotchBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_buffer_max(s : DshashhopscotchBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_buffer_to_string(s : DshashhopscotchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_cursor_make(size : Int) -> DshashhopscotchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_cursor_len(s : DshashhopscotchCursor) -> Int { s.size }

pub fn ds_hash_hopscotch_cursor_get(s : DshashhopscotchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_cursor_set(s : DshashhopscotchCursor, i : Int, v : Double) -> DshashhopscotchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cursor_sum(s : DshashhopscotchCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_cursor_mean(s : DshashhopscotchCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_cursor_scale(s : DshashhopscotchCursor, f : Double) -> DshashhopscotchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cursor_add(a : DshashhopscotchCursor, b : DshashhopscotchCursor) -> DshashhopscotchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_cursor_copy(s : DshashhopscotchCursor) -> DshashhopscotchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cursor_fill(s : DshashhopscotchCursor, v : Double) -> DshashhopscotchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_cursor_min(s : DshashhopscotchCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_cursor_max(s : DshashhopscotchCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_cursor_to_string(s : DshashhopscotchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_view_make(size : Int) -> DshashhopscotchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_view_len(s : DshashhopscotchView) -> Int { s.size }

pub fn ds_hash_hopscotch_view_get(s : DshashhopscotchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_view_set(s : DshashhopscotchView, i : Int, v : Double) -> DshashhopscotchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_view_sum(s : DshashhopscotchView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_view_mean(s : DshashhopscotchView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_view_scale(s : DshashhopscotchView, f : Double) -> DshashhopscotchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_view_add(a : DshashhopscotchView, b : DshashhopscotchView) -> DshashhopscotchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_view_copy(s : DshashhopscotchView) -> DshashhopscotchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_view_fill(s : DshashhopscotchView, v : Double) -> DshashhopscotchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_view_min(s : DshashhopscotchView) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_view_max(s : DshashhopscotchView) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_view_to_string(s : DshashhopscotchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_range_make(size : Int) -> DshashhopscotchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_range_len(s : DshashhopscotchRange) -> Int { s.size }

pub fn ds_hash_hopscotch_range_get(s : DshashhopscotchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_range_set(s : DshashhopscotchRange, i : Int, v : Double) -> DshashhopscotchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_range_sum(s : DshashhopscotchRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_range_mean(s : DshashhopscotchRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_range_scale(s : DshashhopscotchRange, f : Double) -> DshashhopscotchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_range_add(a : DshashhopscotchRange, b : DshashhopscotchRange) -> DshashhopscotchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_range_copy(s : DshashhopscotchRange) -> DshashhopscotchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_range_fill(s : DshashhopscotchRange, v : Double) -> DshashhopscotchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_range_min(s : DshashhopscotchRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_range_max(s : DshashhopscotchRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_range_to_string(s : DshashhopscotchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_slice_make(size : Int) -> DshashhopscotchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_slice_len(s : DshashhopscotchSlice) -> Int { s.size }

pub fn ds_hash_hopscotch_slice_get(s : DshashhopscotchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_slice_set(s : DshashhopscotchSlice, i : Int, v : Double) -> DshashhopscotchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_slice_sum(s : DshashhopscotchSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_hopscotch_slice_mean(s : DshashhopscotchSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_hopscotch_slice_scale(s : DshashhopscotchSlice, f : Double) -> DshashhopscotchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_slice_add(a : DshashhopscotchSlice, b : DshashhopscotchSlice) -> DshashhopscotchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_hopscotch_slice_copy(s : DshashhopscotchSlice) -> DshashhopscotchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_slice_fill(s : DshashhopscotchSlice, v : Double) -> DshashhopscotchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_hopscotch_slice_min(s : DshashhopscotchSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_hopscotch_slice_max(s : DshashhopscotchSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_hopscotch_slice_to_string(s : DshashhopscotchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

