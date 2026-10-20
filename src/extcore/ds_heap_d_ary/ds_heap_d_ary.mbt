///===
/// extcore/ds_heap_d_ary

pub(all) struct DsheapdaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_d_ary_make_point(x : Double, y : Double) -> DsheapdaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_d_ary_make_point3(x : Double, y : Double, z : Double) -> DsheapdaryPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapdaryPoint::x(self : DsheapdaryPoint) -> Double { self.x }

pub fn DsheapdaryPoint::y(self : DsheapdaryPoint) -> Double { self.y }

pub fn DsheapdaryPoint::z(self : DsheapdaryPoint) -> Double { self.z }

pub fn DsheapdaryPoint::label(self : DsheapdaryPoint) -> Int { self.label }

pub fn DsheapdaryPoint::dist(self : DsheapdaryPoint, other : DsheapdaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapdaryPoint::add(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapdaryPoint::sub(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapdaryPoint::scale(self : DsheapdaryPoint, s : Double) -> DsheapdaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapdaryPoint::dot(self : DsheapdaryPoint, other : DsheapdaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapdaryPoint::cross(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapdaryPoint::norm(self : DsheapdaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapdaryPoint::normalize(self : DsheapdaryPoint) -> DsheapdaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapdaryPoint::negate(self : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapdaryPoint::mid(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapdaryPoint::lerp(self : DsheapdaryPoint, other : DsheapdaryPoint, t : Double) -> DsheapdaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapdaryPoint::to_string(self : DsheapdaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapdarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_d_ary_make_series(vals : Array[Double], name : String) -> DsheapdarySeries {
  { vals, name, meta: 0 }
}

pub fn DsheapdarySeries::len(self : DsheapdarySeries) -> Int { self.vals.length() }

pub fn DsheapdarySeries::sum(self : DsheapdarySeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapdarySeries::mean(self : DsheapdarySeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapdarySeries::min(self : DsheapdarySeries) -> Double { @_common.min(self.vals) }

pub fn DsheapdarySeries::max(self : DsheapdarySeries) -> Double { @_common.max(self.vals) }

pub fn DsheapdarySeries::range(self : DsheapdarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapdarySeries::variance(self : DsheapdarySeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapdarySeries::std(self : DsheapdarySeries) -> Double { @_common.std(self.vals) }

pub fn DsheapdarySeries::median(self : DsheapdarySeries) -> Double { @_common.median(self.vals) }

pub fn DsheapdarySeries::scale(self : DsheapdarySeries, f : Double) -> DsheapdarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapdarySeries::add(self : DsheapdarySeries, other : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapdarySeries::sub(self : DsheapdarySeries, other : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapdarySeries::normalize(self : DsheapdarySeries) -> DsheapdarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapdarySeries::cumsum(self : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapdarySeries::to_string(self : DsheapdarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapdaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_d_ary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapdaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_d_ary_matrix_identity(n : Int) -> DsheapdaryMatrix {
  let m = ds_heap_d_ary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapdaryMatrix::get(self : DsheapdaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapdaryMatrix::transpose(self : DsheapdaryMatrix) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapdaryMatrix::add(self : DsheapdaryMatrix, other : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_d_ary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapdaryMatrix::scale(self : DsheapdaryMatrix, s : Double) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapdaryMatrix::multiply(self : DsheapdaryMatrix, other : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if self.cols != other.rows { return ds_heap_d_ary_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_d_ary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapdaryMatrix::trace(self : DsheapdaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapdaryMatrix::det(self : DsheapdaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapdaryMatrix::norm(self : DsheapdaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapdaryMatrix::to_string(self : DsheapdaryMatrix) -> String {
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

pub(all) struct DsheapdaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_d_ary_make_vector(comps : Array[Double]) -> DsheapdaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_d_ary_vector_zero(dim : Int) -> DsheapdaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapdaryVector::add(self : DsheapdaryVector, other : DsheapdaryVector) -> DsheapdaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapdaryVector::sub(self : DsheapdaryVector, other : DsheapdaryVector) -> DsheapdaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapdaryVector::scale(self : DsheapdaryVector, s : Double) -> DsheapdaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapdaryVector::dot(self : DsheapdaryVector, other : DsheapdaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapdaryVector::norm(self : DsheapdaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapdaryVector::normalize(self : DsheapdaryVector) -> DsheapdaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapdaryVector::dist(self : DsheapdaryVector, other : DsheapdaryVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapdaryVector::to_string(self : DsheapdaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_d_ary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_d_ary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_d_ary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_d_ary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_d_ary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_d_ary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_d_ary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_d_ary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_d_ary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_d_ary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_d_ary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_d_ary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_d_ary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_d_ary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_d_ary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_d_ary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_d_ary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_d_ary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_d_ary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_d_ary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_d_ary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_d_ary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_d_ary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_d_ary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_d_ary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_d_ary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_d_ary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_d_ary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_d_ary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapdaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_frame_make(size : Int) -> DsheapdaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_frame_len(s : DsheapdaryFrame) -> Int { s.size }

pub fn ds_heap_d_ary_frame_get(s : DsheapdaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_frame_set(s : DsheapdaryFrame, i : Int, v : Double) -> DsheapdaryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_frame_sum(s : DsheapdaryFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_frame_mean(s : DsheapdaryFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_frame_scale(s : DsheapdaryFrame, f : Double) -> DsheapdaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_frame_add(a : DsheapdaryFrame, b : DsheapdaryFrame) -> DsheapdaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_frame_copy(s : DsheapdaryFrame) -> DsheapdaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_frame_fill(s : DsheapdaryFrame, v : Double) -> DsheapdaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_frame_min(s : DsheapdaryFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_frame_max(s : DsheapdaryFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_frame_to_string(s : DsheapdaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_table_make(size : Int) -> DsheapdaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_table_len(s : DsheapdaryTable) -> Int { s.size }

pub fn ds_heap_d_ary_table_get(s : DsheapdaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_table_set(s : DsheapdaryTable, i : Int, v : Double) -> DsheapdaryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_table_sum(s : DsheapdaryTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_table_mean(s : DsheapdaryTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_table_scale(s : DsheapdaryTable, f : Double) -> DsheapdaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_table_add(a : DsheapdaryTable, b : DsheapdaryTable) -> DsheapdaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_table_copy(s : DsheapdaryTable) -> DsheapdaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_table_fill(s : DsheapdaryTable, v : Double) -> DsheapdaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_table_min(s : DsheapdaryTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_table_max(s : DsheapdaryTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_table_to_string(s : DsheapdaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_graphn_make(size : Int) -> DsheapdaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_graphn_len(s : DsheapdaryGraphN) -> Int { s.size }

pub fn ds_heap_d_ary_graphn_get(s : DsheapdaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_graphn_set(s : DsheapdaryGraphN, i : Int, v : Double) -> DsheapdaryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_graphn_sum(s : DsheapdaryGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_graphn_mean(s : DsheapdaryGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_graphn_scale(s : DsheapdaryGraphN, f : Double) -> DsheapdaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_graphn_add(a : DsheapdaryGraphN, b : DsheapdaryGraphN) -> DsheapdaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_graphn_copy(s : DsheapdaryGraphN) -> DsheapdaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_graphn_fill(s : DsheapdaryGraphN, v : Double) -> DsheapdaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_graphn_min(s : DsheapdaryGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_graphn_max(s : DsheapdaryGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_graphn_to_string(s : DsheapdaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_node_make(size : Int) -> DsheapdaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_node_len(s : DsheapdaryNode) -> Int { s.size }

pub fn ds_heap_d_ary_node_get(s : DsheapdaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_node_set(s : DsheapdaryNode, i : Int, v : Double) -> DsheapdaryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_node_sum(s : DsheapdaryNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_node_mean(s : DsheapdaryNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_node_scale(s : DsheapdaryNode, f : Double) -> DsheapdaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_node_add(a : DsheapdaryNode, b : DsheapdaryNode) -> DsheapdaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_node_copy(s : DsheapdaryNode) -> DsheapdaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_node_fill(s : DsheapdaryNode, v : Double) -> DsheapdaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_node_min(s : DsheapdaryNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_node_max(s : DsheapdaryNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_node_to_string(s : DsheapdaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_edge_make(size : Int) -> DsheapdaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_edge_len(s : DsheapdaryEdge) -> Int { s.size }

pub fn ds_heap_d_ary_edge_get(s : DsheapdaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_edge_set(s : DsheapdaryEdge, i : Int, v : Double) -> DsheapdaryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_edge_sum(s : DsheapdaryEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_edge_mean(s : DsheapdaryEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_edge_scale(s : DsheapdaryEdge, f : Double) -> DsheapdaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_edge_add(a : DsheapdaryEdge, b : DsheapdaryEdge) -> DsheapdaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_edge_copy(s : DsheapdaryEdge) -> DsheapdaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_edge_fill(s : DsheapdaryEdge, v : Double) -> DsheapdaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_edge_min(s : DsheapdaryEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_edge_max(s : DsheapdaryEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_edge_to_string(s : DsheapdaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_path_make(size : Int) -> DsheapdaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_path_len(s : DsheapdaryPath) -> Int { s.size }

pub fn ds_heap_d_ary_path_get(s : DsheapdaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_path_set(s : DsheapdaryPath, i : Int, v : Double) -> DsheapdaryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_path_sum(s : DsheapdaryPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_path_mean(s : DsheapdaryPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_path_scale(s : DsheapdaryPath, f : Double) -> DsheapdaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_path_add(a : DsheapdaryPath, b : DsheapdaryPath) -> DsheapdaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_path_copy(s : DsheapdaryPath) -> DsheapdaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_path_fill(s : DsheapdaryPath, v : Double) -> DsheapdaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_path_min(s : DsheapdaryPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_path_max(s : DsheapdaryPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_path_to_string(s : DsheapdaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cluster_make(size : Int) -> DsheapdaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_cluster_len(s : DsheapdaryCluster) -> Int { s.size }

pub fn ds_heap_d_ary_cluster_get(s : DsheapdaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_cluster_set(s : DsheapdaryCluster, i : Int, v : Double) -> DsheapdaryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cluster_sum(s : DsheapdaryCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_cluster_mean(s : DsheapdaryCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_cluster_scale(s : DsheapdaryCluster, f : Double) -> DsheapdaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cluster_add(a : DsheapdaryCluster, b : DsheapdaryCluster) -> DsheapdaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_cluster_copy(s : DsheapdaryCluster) -> DsheapdaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cluster_fill(s : DsheapdaryCluster, v : Double) -> DsheapdaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cluster_min(s : DsheapdaryCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_cluster_max(s : DsheapdaryCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_cluster_to_string(s : DsheapdaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_model_make(size : Int) -> DsheapdaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_model_len(s : DsheapdaryModel) -> Int { s.size }

pub fn ds_heap_d_ary_model_get(s : DsheapdaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_model_set(s : DsheapdaryModel, i : Int, v : Double) -> DsheapdaryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_model_sum(s : DsheapdaryModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_model_mean(s : DsheapdaryModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_model_scale(s : DsheapdaryModel, f : Double) -> DsheapdaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_model_add(a : DsheapdaryModel, b : DsheapdaryModel) -> DsheapdaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_model_copy(s : DsheapdaryModel) -> DsheapdaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_model_fill(s : DsheapdaryModel, v : Double) -> DsheapdaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_model_min(s : DsheapdaryModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_model_max(s : DsheapdaryModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_model_to_string(s : DsheapdaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_layer_make(size : Int) -> DsheapdaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_layer_len(s : DsheapdaryLayer) -> Int { s.size }

pub fn ds_heap_d_ary_layer_get(s : DsheapdaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_layer_set(s : DsheapdaryLayer, i : Int, v : Double) -> DsheapdaryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_layer_sum(s : DsheapdaryLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_layer_mean(s : DsheapdaryLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_layer_scale(s : DsheapdaryLayer, f : Double) -> DsheapdaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_layer_add(a : DsheapdaryLayer, b : DsheapdaryLayer) -> DsheapdaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_layer_copy(s : DsheapdaryLayer) -> DsheapdaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_layer_fill(s : DsheapdaryLayer, v : Double) -> DsheapdaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_layer_min(s : DsheapdaryLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_layer_max(s : DsheapdaryLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_layer_to_string(s : DsheapdaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_buffer_make(size : Int) -> DsheapdaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_buffer_len(s : DsheapdaryBuffer) -> Int { s.size }

pub fn ds_heap_d_ary_buffer_get(s : DsheapdaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_buffer_set(s : DsheapdaryBuffer, i : Int, v : Double) -> DsheapdaryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_buffer_sum(s : DsheapdaryBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_buffer_mean(s : DsheapdaryBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_buffer_scale(s : DsheapdaryBuffer, f : Double) -> DsheapdaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_buffer_add(a : DsheapdaryBuffer, b : DsheapdaryBuffer) -> DsheapdaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_buffer_copy(s : DsheapdaryBuffer) -> DsheapdaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_buffer_fill(s : DsheapdaryBuffer, v : Double) -> DsheapdaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_buffer_min(s : DsheapdaryBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_buffer_max(s : DsheapdaryBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_buffer_to_string(s : DsheapdaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cursor_make(size : Int) -> DsheapdaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_cursor_len(s : DsheapdaryCursor) -> Int { s.size }

pub fn ds_heap_d_ary_cursor_get(s : DsheapdaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_cursor_set(s : DsheapdaryCursor, i : Int, v : Double) -> DsheapdaryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cursor_sum(s : DsheapdaryCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_cursor_mean(s : DsheapdaryCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_cursor_scale(s : DsheapdaryCursor, f : Double) -> DsheapdaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cursor_add(a : DsheapdaryCursor, b : DsheapdaryCursor) -> DsheapdaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_cursor_copy(s : DsheapdaryCursor) -> DsheapdaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cursor_fill(s : DsheapdaryCursor, v : Double) -> DsheapdaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_cursor_min(s : DsheapdaryCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_cursor_max(s : DsheapdaryCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_cursor_to_string(s : DsheapdaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_view_make(size : Int) -> DsheapdaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_view_len(s : DsheapdaryView) -> Int { s.size }

pub fn ds_heap_d_ary_view_get(s : DsheapdaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_view_set(s : DsheapdaryView, i : Int, v : Double) -> DsheapdaryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_view_sum(s : DsheapdaryView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_view_mean(s : DsheapdaryView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_view_scale(s : DsheapdaryView, f : Double) -> DsheapdaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_view_add(a : DsheapdaryView, b : DsheapdaryView) -> DsheapdaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_view_copy(s : DsheapdaryView) -> DsheapdaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_view_fill(s : DsheapdaryView, v : Double) -> DsheapdaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_view_min(s : DsheapdaryView) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_view_max(s : DsheapdaryView) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_view_to_string(s : DsheapdaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_range_make(size : Int) -> DsheapdaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_range_len(s : DsheapdaryRange) -> Int { s.size }

pub fn ds_heap_d_ary_range_get(s : DsheapdaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_range_set(s : DsheapdaryRange, i : Int, v : Double) -> DsheapdaryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_range_sum(s : DsheapdaryRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_range_mean(s : DsheapdaryRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_range_scale(s : DsheapdaryRange, f : Double) -> DsheapdaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_range_add(a : DsheapdaryRange, b : DsheapdaryRange) -> DsheapdaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_range_copy(s : DsheapdaryRange) -> DsheapdaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_range_fill(s : DsheapdaryRange, v : Double) -> DsheapdaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_range_min(s : DsheapdaryRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_range_max(s : DsheapdaryRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_range_to_string(s : DsheapdaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_slice_make(size : Int) -> DsheapdarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_slice_len(s : DsheapdarySlice) -> Int { s.size }

pub fn ds_heap_d_ary_slice_get(s : DsheapdarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_slice_set(s : DsheapdarySlice, i : Int, v : Double) -> DsheapdarySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_slice_sum(s : DsheapdarySlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_d_ary_slice_mean(s : DsheapdarySlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_d_ary_slice_scale(s : DsheapdarySlice, f : Double) -> DsheapdarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_slice_add(a : DsheapdarySlice, b : DsheapdarySlice) -> DsheapdarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_d_ary_slice_copy(s : DsheapdarySlice) -> DsheapdarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_slice_fill(s : DsheapdarySlice, v : Double) -> DsheapdarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_d_ary_slice_min(s : DsheapdarySlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_d_ary_slice_max(s : DsheapdarySlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_d_ary_slice_to_string(s : DsheapdarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

