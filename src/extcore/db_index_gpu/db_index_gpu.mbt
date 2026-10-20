///===
/// extcore/db_index_gpu

pub(all) struct DbindexgpuPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_gpu_make_point(x : Double, y : Double) -> DbindexgpuPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_gpu_make_point3(x : Double, y : Double, z : Double) -> DbindexgpuPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexgpuPoint::x(self : DbindexgpuPoint) -> Double { self.x }

pub fn DbindexgpuPoint::y(self : DbindexgpuPoint) -> Double { self.y }

pub fn DbindexgpuPoint::z(self : DbindexgpuPoint) -> Double { self.z }

pub fn DbindexgpuPoint::label(self : DbindexgpuPoint) -> Int { self.label }

pub fn DbindexgpuPoint::dist(self : DbindexgpuPoint, other : DbindexgpuPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexgpuPoint::add(self : DbindexgpuPoint, other : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexgpuPoint::sub(self : DbindexgpuPoint, other : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexgpuPoint::scale(self : DbindexgpuPoint, s : Double) -> DbindexgpuPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexgpuPoint::dot(self : DbindexgpuPoint, other : DbindexgpuPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexgpuPoint::cross(self : DbindexgpuPoint, other : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexgpuPoint::norm(self : DbindexgpuPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexgpuPoint::normalize(self : DbindexgpuPoint) -> DbindexgpuPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexgpuPoint::negate(self : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexgpuPoint::mid(self : DbindexgpuPoint, other : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexgpuPoint::lerp(self : DbindexgpuPoint, other : DbindexgpuPoint, t : Double) -> DbindexgpuPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexgpuPoint::to_string(self : DbindexgpuPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexgpuSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_gpu_make_series(vals : Array[Double], name : String) -> DbindexgpuSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexgpuSeries::len(self : DbindexgpuSeries) -> Int { self.vals.length() }

pub fn DbindexgpuSeries::sum(self : DbindexgpuSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexgpuSeries::mean(self : DbindexgpuSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexgpuSeries::min(self : DbindexgpuSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexgpuSeries::max(self : DbindexgpuSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexgpuSeries::range(self : DbindexgpuSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexgpuSeries::variance(self : DbindexgpuSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexgpuSeries::std(self : DbindexgpuSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexgpuSeries::median(self : DbindexgpuSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexgpuSeries::scale(self : DbindexgpuSeries, f : Double) -> DbindexgpuSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexgpuSeries::add(self : DbindexgpuSeries, other : DbindexgpuSeries) -> DbindexgpuSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexgpuSeries::sub(self : DbindexgpuSeries, other : DbindexgpuSeries) -> DbindexgpuSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexgpuSeries::normalize(self : DbindexgpuSeries) -> DbindexgpuSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexgpuSeries::cumsum(self : DbindexgpuSeries) -> DbindexgpuSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexgpuSeries::to_string(self : DbindexgpuSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexgpuMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_gpu_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexgpuMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_gpu_matrix_identity(n : Int) -> DbindexgpuMatrix {
  let m = db_index_gpu_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexgpuMatrix::get(self : DbindexgpuMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexgpuMatrix::transpose(self : DbindexgpuMatrix) -> DbindexgpuMatrix {
  let result = db_index_gpu_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexgpuMatrix::add(self : DbindexgpuMatrix, other : DbindexgpuMatrix) -> DbindexgpuMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_gpu_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexgpuMatrix::scale(self : DbindexgpuMatrix, s : Double) -> DbindexgpuMatrix {
  let result = db_index_gpu_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexgpuMatrix::multiply(self : DbindexgpuMatrix, other : DbindexgpuMatrix) -> DbindexgpuMatrix {
  if self.cols != other.rows { return db_index_gpu_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_gpu_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexgpuMatrix::trace(self : DbindexgpuMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexgpuMatrix::det(self : DbindexgpuMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexgpuMatrix::norm(self : DbindexgpuMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexgpuMatrix::to_string(self : DbindexgpuMatrix) -> String {
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

pub(all) struct DbindexgpuVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_gpu_make_vector(comps : Array[Double]) -> DbindexgpuVector {
  { comps, dim: comps.length() }
}

pub fn db_index_gpu_vector_zero(dim : Int) -> DbindexgpuVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexgpuVector::add(self : DbindexgpuVector, other : DbindexgpuVector) -> DbindexgpuVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexgpuVector::sub(self : DbindexgpuVector, other : DbindexgpuVector) -> DbindexgpuVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexgpuVector::scale(self : DbindexgpuVector, s : Double) -> DbindexgpuVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexgpuVector::dot(self : DbindexgpuVector, other : DbindexgpuVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexgpuVector::norm(self : DbindexgpuVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexgpuVector::normalize(self : DbindexgpuVector) -> DbindexgpuVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexgpuVector::dist(self : DbindexgpuVector, other : DbindexgpuVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexgpuVector::to_string(self : DbindexgpuVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_gpu_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_gpu_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_gpu_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_gpu_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_gpu_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_gpu_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_gpu_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_gpu_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_gpu_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_gpu_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_gpu_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_gpu_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_gpu_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_gpu_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_gpu_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_gpu_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_gpu_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_gpu_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_gpu_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_gpu_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_gpu_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_gpu_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_gpu_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_gpu_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_gpu_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_gpu_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_gpu_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_gpu_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_gpu_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexgpuFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_frame_make(size : Int) -> DbindexgpuFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_frame_len(s : DbindexgpuFrame) -> Int { s.size }

pub fn db_index_gpu_frame_get(s : DbindexgpuFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_frame_set(s : DbindexgpuFrame, i : Int, v : Double) -> DbindexgpuFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_frame_sum(s : DbindexgpuFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_frame_mean(s : DbindexgpuFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_frame_scale(s : DbindexgpuFrame, f : Double) -> DbindexgpuFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_frame_add(a : DbindexgpuFrame, b : DbindexgpuFrame) -> DbindexgpuFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_frame_copy(s : DbindexgpuFrame) -> DbindexgpuFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_frame_fill(s : DbindexgpuFrame, v : Double) -> DbindexgpuFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_frame_min(s : DbindexgpuFrame) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_frame_max(s : DbindexgpuFrame) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_frame_to_string(s : DbindexgpuFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_table_make(size : Int) -> DbindexgpuTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_table_len(s : DbindexgpuTable) -> Int { s.size }

pub fn db_index_gpu_table_get(s : DbindexgpuTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_table_set(s : DbindexgpuTable, i : Int, v : Double) -> DbindexgpuTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_table_sum(s : DbindexgpuTable) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_table_mean(s : DbindexgpuTable) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_table_scale(s : DbindexgpuTable, f : Double) -> DbindexgpuTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_table_add(a : DbindexgpuTable, b : DbindexgpuTable) -> DbindexgpuTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_table_copy(s : DbindexgpuTable) -> DbindexgpuTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_table_fill(s : DbindexgpuTable, v : Double) -> DbindexgpuTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_table_min(s : DbindexgpuTable) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_table_max(s : DbindexgpuTable) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_table_to_string(s : DbindexgpuTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_graphn_make(size : Int) -> DbindexgpuGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_graphn_len(s : DbindexgpuGraphN) -> Int { s.size }

pub fn db_index_gpu_graphn_get(s : DbindexgpuGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_graphn_set(s : DbindexgpuGraphN, i : Int, v : Double) -> DbindexgpuGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_graphn_sum(s : DbindexgpuGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_graphn_mean(s : DbindexgpuGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_graphn_scale(s : DbindexgpuGraphN, f : Double) -> DbindexgpuGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_graphn_add(a : DbindexgpuGraphN, b : DbindexgpuGraphN) -> DbindexgpuGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_graphn_copy(s : DbindexgpuGraphN) -> DbindexgpuGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_graphn_fill(s : DbindexgpuGraphN, v : Double) -> DbindexgpuGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_graphn_min(s : DbindexgpuGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_graphn_max(s : DbindexgpuGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_graphn_to_string(s : DbindexgpuGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_node_make(size : Int) -> DbindexgpuNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_node_len(s : DbindexgpuNode) -> Int { s.size }

pub fn db_index_gpu_node_get(s : DbindexgpuNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_node_set(s : DbindexgpuNode, i : Int, v : Double) -> DbindexgpuNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_node_sum(s : DbindexgpuNode) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_node_mean(s : DbindexgpuNode) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_node_scale(s : DbindexgpuNode, f : Double) -> DbindexgpuNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_node_add(a : DbindexgpuNode, b : DbindexgpuNode) -> DbindexgpuNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_node_copy(s : DbindexgpuNode) -> DbindexgpuNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_node_fill(s : DbindexgpuNode, v : Double) -> DbindexgpuNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_node_min(s : DbindexgpuNode) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_node_max(s : DbindexgpuNode) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_node_to_string(s : DbindexgpuNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_edge_make(size : Int) -> DbindexgpuEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_edge_len(s : DbindexgpuEdge) -> Int { s.size }

pub fn db_index_gpu_edge_get(s : DbindexgpuEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_edge_set(s : DbindexgpuEdge, i : Int, v : Double) -> DbindexgpuEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_edge_sum(s : DbindexgpuEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_edge_mean(s : DbindexgpuEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_edge_scale(s : DbindexgpuEdge, f : Double) -> DbindexgpuEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_edge_add(a : DbindexgpuEdge, b : DbindexgpuEdge) -> DbindexgpuEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_edge_copy(s : DbindexgpuEdge) -> DbindexgpuEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_edge_fill(s : DbindexgpuEdge, v : Double) -> DbindexgpuEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_edge_min(s : DbindexgpuEdge) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_edge_max(s : DbindexgpuEdge) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_edge_to_string(s : DbindexgpuEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_path_make(size : Int) -> DbindexgpuPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_path_len(s : DbindexgpuPath) -> Int { s.size }

pub fn db_index_gpu_path_get(s : DbindexgpuPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_path_set(s : DbindexgpuPath, i : Int, v : Double) -> DbindexgpuPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_path_sum(s : DbindexgpuPath) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_path_mean(s : DbindexgpuPath) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_path_scale(s : DbindexgpuPath, f : Double) -> DbindexgpuPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_path_add(a : DbindexgpuPath, b : DbindexgpuPath) -> DbindexgpuPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_path_copy(s : DbindexgpuPath) -> DbindexgpuPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_path_fill(s : DbindexgpuPath, v : Double) -> DbindexgpuPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_path_min(s : DbindexgpuPath) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_path_max(s : DbindexgpuPath) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_path_to_string(s : DbindexgpuPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_cluster_make(size : Int) -> DbindexgpuCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_cluster_len(s : DbindexgpuCluster) -> Int { s.size }

pub fn db_index_gpu_cluster_get(s : DbindexgpuCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_cluster_set(s : DbindexgpuCluster, i : Int, v : Double) -> DbindexgpuCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cluster_sum(s : DbindexgpuCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_cluster_mean(s : DbindexgpuCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_cluster_scale(s : DbindexgpuCluster, f : Double) -> DbindexgpuCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cluster_add(a : DbindexgpuCluster, b : DbindexgpuCluster) -> DbindexgpuCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_cluster_copy(s : DbindexgpuCluster) -> DbindexgpuCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cluster_fill(s : DbindexgpuCluster, v : Double) -> DbindexgpuCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cluster_min(s : DbindexgpuCluster) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_cluster_max(s : DbindexgpuCluster) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_cluster_to_string(s : DbindexgpuCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_model_make(size : Int) -> DbindexgpuModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_model_len(s : DbindexgpuModel) -> Int { s.size }

pub fn db_index_gpu_model_get(s : DbindexgpuModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_model_set(s : DbindexgpuModel, i : Int, v : Double) -> DbindexgpuModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_model_sum(s : DbindexgpuModel) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_model_mean(s : DbindexgpuModel) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_model_scale(s : DbindexgpuModel, f : Double) -> DbindexgpuModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_model_add(a : DbindexgpuModel, b : DbindexgpuModel) -> DbindexgpuModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_model_copy(s : DbindexgpuModel) -> DbindexgpuModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_model_fill(s : DbindexgpuModel, v : Double) -> DbindexgpuModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_model_min(s : DbindexgpuModel) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_model_max(s : DbindexgpuModel) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_model_to_string(s : DbindexgpuModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_layer_make(size : Int) -> DbindexgpuLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_layer_len(s : DbindexgpuLayer) -> Int { s.size }

pub fn db_index_gpu_layer_get(s : DbindexgpuLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_layer_set(s : DbindexgpuLayer, i : Int, v : Double) -> DbindexgpuLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_layer_sum(s : DbindexgpuLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_layer_mean(s : DbindexgpuLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_layer_scale(s : DbindexgpuLayer, f : Double) -> DbindexgpuLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_layer_add(a : DbindexgpuLayer, b : DbindexgpuLayer) -> DbindexgpuLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_layer_copy(s : DbindexgpuLayer) -> DbindexgpuLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_layer_fill(s : DbindexgpuLayer, v : Double) -> DbindexgpuLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_layer_min(s : DbindexgpuLayer) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_layer_max(s : DbindexgpuLayer) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_layer_to_string(s : DbindexgpuLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_buffer_make(size : Int) -> DbindexgpuBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_buffer_len(s : DbindexgpuBuffer) -> Int { s.size }

pub fn db_index_gpu_buffer_get(s : DbindexgpuBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_buffer_set(s : DbindexgpuBuffer, i : Int, v : Double) -> DbindexgpuBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_buffer_sum(s : DbindexgpuBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_buffer_mean(s : DbindexgpuBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_buffer_scale(s : DbindexgpuBuffer, f : Double) -> DbindexgpuBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_buffer_add(a : DbindexgpuBuffer, b : DbindexgpuBuffer) -> DbindexgpuBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_buffer_copy(s : DbindexgpuBuffer) -> DbindexgpuBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_buffer_fill(s : DbindexgpuBuffer, v : Double) -> DbindexgpuBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_buffer_min(s : DbindexgpuBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_buffer_max(s : DbindexgpuBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_buffer_to_string(s : DbindexgpuBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_cursor_make(size : Int) -> DbindexgpuCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_cursor_len(s : DbindexgpuCursor) -> Int { s.size }

pub fn db_index_gpu_cursor_get(s : DbindexgpuCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_cursor_set(s : DbindexgpuCursor, i : Int, v : Double) -> DbindexgpuCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cursor_sum(s : DbindexgpuCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_cursor_mean(s : DbindexgpuCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_cursor_scale(s : DbindexgpuCursor, f : Double) -> DbindexgpuCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cursor_add(a : DbindexgpuCursor, b : DbindexgpuCursor) -> DbindexgpuCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_cursor_copy(s : DbindexgpuCursor) -> DbindexgpuCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cursor_fill(s : DbindexgpuCursor, v : Double) -> DbindexgpuCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_cursor_min(s : DbindexgpuCursor) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_cursor_max(s : DbindexgpuCursor) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_cursor_to_string(s : DbindexgpuCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_view_make(size : Int) -> DbindexgpuView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_view_len(s : DbindexgpuView) -> Int { s.size }

pub fn db_index_gpu_view_get(s : DbindexgpuView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_view_set(s : DbindexgpuView, i : Int, v : Double) -> DbindexgpuView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_view_sum(s : DbindexgpuView) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_view_mean(s : DbindexgpuView) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_view_scale(s : DbindexgpuView, f : Double) -> DbindexgpuView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_view_add(a : DbindexgpuView, b : DbindexgpuView) -> DbindexgpuView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_view_copy(s : DbindexgpuView) -> DbindexgpuView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_view_fill(s : DbindexgpuView, v : Double) -> DbindexgpuView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_view_min(s : DbindexgpuView) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_view_max(s : DbindexgpuView) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_view_to_string(s : DbindexgpuView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_range_make(size : Int) -> DbindexgpuRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_range_len(s : DbindexgpuRange) -> Int { s.size }

pub fn db_index_gpu_range_get(s : DbindexgpuRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_range_set(s : DbindexgpuRange, i : Int, v : Double) -> DbindexgpuRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_range_sum(s : DbindexgpuRange) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_range_mean(s : DbindexgpuRange) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_range_scale(s : DbindexgpuRange, f : Double) -> DbindexgpuRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_range_add(a : DbindexgpuRange, b : DbindexgpuRange) -> DbindexgpuRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_range_copy(s : DbindexgpuRange) -> DbindexgpuRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_range_fill(s : DbindexgpuRange, v : Double) -> DbindexgpuRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_range_min(s : DbindexgpuRange) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_range_max(s : DbindexgpuRange) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_range_to_string(s : DbindexgpuRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgpuSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gpu_slice_make(size : Int) -> DbindexgpuSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gpu_slice_len(s : DbindexgpuSlice) -> Int { s.size }

pub fn db_index_gpu_slice_get(s : DbindexgpuSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gpu_slice_set(s : DbindexgpuSlice, i : Int, v : Double) -> DbindexgpuSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_gpu_slice_sum(s : DbindexgpuSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_gpu_slice_mean(s : DbindexgpuSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_gpu_slice_scale(s : DbindexgpuSlice, f : Double) -> DbindexgpuSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_slice_add(a : DbindexgpuSlice, b : DbindexgpuSlice) -> DbindexgpuSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_gpu_slice_copy(s : DbindexgpuSlice) -> DbindexgpuSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_slice_fill(s : DbindexgpuSlice, v : Double) -> DbindexgpuSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_gpu_slice_min(s : DbindexgpuSlice) -> Double { @_common.min(s.data) }

pub fn db_index_gpu_slice_max(s : DbindexgpuSlice) -> Double { @_common.max(s.data) }

pub fn db_index_gpu_slice_to_string(s : DbindexgpuSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

