///===
/// extcore/ds_hash_perfect

pub(all) struct DshashperfectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_perfect_make_point(x : Double, y : Double) -> DshashperfectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_perfect_make_point3(x : Double, y : Double, z : Double) -> DshashperfectPoint {
  { x, y, z, label: 0 }
}

pub fn DshashperfectPoint::x(self : DshashperfectPoint) -> Double { self.x }

pub fn DshashperfectPoint::y(self : DshashperfectPoint) -> Double { self.y }

pub fn DshashperfectPoint::z(self : DshashperfectPoint) -> Double { self.z }

pub fn DshashperfectPoint::label(self : DshashperfectPoint) -> Int { self.label }

pub fn DshashperfectPoint::dist(self : DshashperfectPoint, other : DshashperfectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashperfectPoint::add(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashperfectPoint::sub(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashperfectPoint::scale(self : DshashperfectPoint, s : Double) -> DshashperfectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashperfectPoint::dot(self : DshashperfectPoint, other : DshashperfectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashperfectPoint::cross(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashperfectPoint::norm(self : DshashperfectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashperfectPoint::normalize(self : DshashperfectPoint) -> DshashperfectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashperfectPoint::negate(self : DshashperfectPoint) -> DshashperfectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashperfectPoint::mid(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashperfectPoint::lerp(self : DshashperfectPoint, other : DshashperfectPoint, t : Double) -> DshashperfectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashperfectPoint::to_string(self : DshashperfectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashperfectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_perfect_make_series(vals : Array[Double], name : String) -> DshashperfectSeries {
  { vals, name, meta: 0 }
}

pub fn DshashperfectSeries::len(self : DshashperfectSeries) -> Int { self.vals.length() }

pub fn DshashperfectSeries::sum(self : DshashperfectSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashperfectSeries::mean(self : DshashperfectSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashperfectSeries::min(self : DshashperfectSeries) -> Double { @_common.min(self.vals) }

pub fn DshashperfectSeries::max(self : DshashperfectSeries) -> Double { @_common.max(self.vals) }

pub fn DshashperfectSeries::range(self : DshashperfectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashperfectSeries::variance(self : DshashperfectSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashperfectSeries::std(self : DshashperfectSeries) -> Double { @_common.std(self.vals) }

pub fn DshashperfectSeries::median(self : DshashperfectSeries) -> Double { @_common.median(self.vals) }

pub fn DshashperfectSeries::scale(self : DshashperfectSeries, f : Double) -> DshashperfectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashperfectSeries::add(self : DshashperfectSeries, other : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashperfectSeries::sub(self : DshashperfectSeries, other : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashperfectSeries::normalize(self : DshashperfectSeries) -> DshashperfectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashperfectSeries::cumsum(self : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashperfectSeries::to_string(self : DshashperfectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashperfectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_perfect_make_matrix(rows : Int, cols : Int, val : Double) -> DshashperfectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_perfect_matrix_identity(n : Int) -> DshashperfectMatrix {
  let m = ds_hash_perfect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashperfectMatrix::get(self : DshashperfectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashperfectMatrix::transpose(self : DshashperfectMatrix) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashperfectMatrix::add(self : DshashperfectMatrix, other : DshashperfectMatrix) -> DshashperfectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_perfect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashperfectMatrix::scale(self : DshashperfectMatrix, s : Double) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashperfectMatrix::multiply(self : DshashperfectMatrix, other : DshashperfectMatrix) -> DshashperfectMatrix {
  if self.cols != other.rows { return ds_hash_perfect_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_perfect_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashperfectMatrix::trace(self : DshashperfectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashperfectMatrix::det(self : DshashperfectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashperfectMatrix::norm(self : DshashperfectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashperfectMatrix::to_string(self : DshashperfectMatrix) -> String {
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

pub(all) struct DshashperfectVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_perfect_make_vector(comps : Array[Double]) -> DshashperfectVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_perfect_vector_zero(dim : Int) -> DshashperfectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashperfectVector::add(self : DshashperfectVector, other : DshashperfectVector) -> DshashperfectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashperfectVector::sub(self : DshashperfectVector, other : DshashperfectVector) -> DshashperfectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashperfectVector::scale(self : DshashperfectVector, s : Double) -> DshashperfectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashperfectVector::dot(self : DshashperfectVector, other : DshashperfectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashperfectVector::norm(self : DshashperfectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashperfectVector::normalize(self : DshashperfectVector) -> DshashperfectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashperfectVector::dist(self : DshashperfectVector, other : DshashperfectVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashperfectVector::to_string(self : DshashperfectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_perfect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_perfect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_perfect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_perfect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_perfect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_perfect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_perfect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_perfect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_perfect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_perfect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_perfect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_perfect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_perfect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_perfect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_perfect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_perfect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_perfect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_perfect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_perfect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_perfect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_perfect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_perfect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_perfect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_perfect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_perfect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_perfect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_perfect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_perfect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_perfect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashperfectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_frame_make(size : Int) -> DshashperfectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectFrame::len(self : DshashperfectFrame) -> Int { self.size }

pub fn DshashperfectFrame::get(self : DshashperfectFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectFrame::set(self : DshashperfectFrame, i : Int, v : Double) -> DshashperfectFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectFrame::sum(self : DshashperfectFrame) -> Double { @_common.sum(self.data) }

pub fn DshashperfectFrame::mean(self : DshashperfectFrame) -> Double { @_common.mean(self.data) }

pub fn DshashperfectFrame::scale(self : DshashperfectFrame, f : Double) -> DshashperfectFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectFrame::add(self : DshashperfectFrame, other : DshashperfectFrame) -> DshashperfectFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectFrame::copy(self : DshashperfectFrame) -> DshashperfectFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectFrame::fill(self : DshashperfectFrame, v : Double) -> DshashperfectFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectFrame::min(self : DshashperfectFrame) -> Double { @_common.min(self.data) }

pub fn DshashperfectFrame::max(self : DshashperfectFrame) -> Double { @_common.max(self.data) }

pub fn DshashperfectFrame::to_string(self : DshashperfectFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_table_make(size : Int) -> DshashperfectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectTable::len(self : DshashperfectTable) -> Int { self.size }

pub fn DshashperfectTable::get(self : DshashperfectTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectTable::set(self : DshashperfectTable, i : Int, v : Double) -> DshashperfectTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectTable::sum(self : DshashperfectTable) -> Double { @_common.sum(self.data) }

pub fn DshashperfectTable::mean(self : DshashperfectTable) -> Double { @_common.mean(self.data) }

pub fn DshashperfectTable::scale(self : DshashperfectTable, f : Double) -> DshashperfectTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectTable::add(self : DshashperfectTable, other : DshashperfectTable) -> DshashperfectTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectTable::copy(self : DshashperfectTable) -> DshashperfectTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectTable::fill(self : DshashperfectTable, v : Double) -> DshashperfectTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectTable::min(self : DshashperfectTable) -> Double { @_common.min(self.data) }

pub fn DshashperfectTable::max(self : DshashperfectTable) -> Double { @_common.max(self.data) }

pub fn DshashperfectTable::to_string(self : DshashperfectTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_graphn_make(size : Int) -> DshashperfectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectGraphN::len(self : DshashperfectGraphN) -> Int { self.size }

pub fn DshashperfectGraphN::get(self : DshashperfectGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectGraphN::set(self : DshashperfectGraphN, i : Int, v : Double) -> DshashperfectGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectGraphN::sum(self : DshashperfectGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashperfectGraphN::mean(self : DshashperfectGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashperfectGraphN::scale(self : DshashperfectGraphN, f : Double) -> DshashperfectGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectGraphN::add(self : DshashperfectGraphN, other : DshashperfectGraphN) -> DshashperfectGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectGraphN::copy(self : DshashperfectGraphN) -> DshashperfectGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectGraphN::fill(self : DshashperfectGraphN, v : Double) -> DshashperfectGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectGraphN::min(self : DshashperfectGraphN) -> Double { @_common.min(self.data) }

pub fn DshashperfectGraphN::max(self : DshashperfectGraphN) -> Double { @_common.max(self.data) }

pub fn DshashperfectGraphN::to_string(self : DshashperfectGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_node_make(size : Int) -> DshashperfectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectNode::len(self : DshashperfectNode) -> Int { self.size }

pub fn DshashperfectNode::get(self : DshashperfectNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectNode::set(self : DshashperfectNode, i : Int, v : Double) -> DshashperfectNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectNode::sum(self : DshashperfectNode) -> Double { @_common.sum(self.data) }

pub fn DshashperfectNode::mean(self : DshashperfectNode) -> Double { @_common.mean(self.data) }

pub fn DshashperfectNode::scale(self : DshashperfectNode, f : Double) -> DshashperfectNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectNode::add(self : DshashperfectNode, other : DshashperfectNode) -> DshashperfectNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectNode::copy(self : DshashperfectNode) -> DshashperfectNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectNode::fill(self : DshashperfectNode, v : Double) -> DshashperfectNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectNode::min(self : DshashperfectNode) -> Double { @_common.min(self.data) }

pub fn DshashperfectNode::max(self : DshashperfectNode) -> Double { @_common.max(self.data) }

pub fn DshashperfectNode::to_string(self : DshashperfectNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_edge_make(size : Int) -> DshashperfectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectEdge::len(self : DshashperfectEdge) -> Int { self.size }

pub fn DshashperfectEdge::get(self : DshashperfectEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectEdge::set(self : DshashperfectEdge, i : Int, v : Double) -> DshashperfectEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectEdge::sum(self : DshashperfectEdge) -> Double { @_common.sum(self.data) }

pub fn DshashperfectEdge::mean(self : DshashperfectEdge) -> Double { @_common.mean(self.data) }

pub fn DshashperfectEdge::scale(self : DshashperfectEdge, f : Double) -> DshashperfectEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectEdge::add(self : DshashperfectEdge, other : DshashperfectEdge) -> DshashperfectEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectEdge::copy(self : DshashperfectEdge) -> DshashperfectEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectEdge::fill(self : DshashperfectEdge, v : Double) -> DshashperfectEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectEdge::min(self : DshashperfectEdge) -> Double { @_common.min(self.data) }

pub fn DshashperfectEdge::max(self : DshashperfectEdge) -> Double { @_common.max(self.data) }

pub fn DshashperfectEdge::to_string(self : DshashperfectEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_path_make(size : Int) -> DshashperfectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectPath::len(self : DshashperfectPath) -> Int { self.size }

pub fn DshashperfectPath::get(self : DshashperfectPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectPath::set(self : DshashperfectPath, i : Int, v : Double) -> DshashperfectPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectPath::sum(self : DshashperfectPath) -> Double { @_common.sum(self.data) }

pub fn DshashperfectPath::mean(self : DshashperfectPath) -> Double { @_common.mean(self.data) }

pub fn DshashperfectPath::scale(self : DshashperfectPath, f : Double) -> DshashperfectPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectPath::add(self : DshashperfectPath, other : DshashperfectPath) -> DshashperfectPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectPath::copy(self : DshashperfectPath) -> DshashperfectPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectPath::fill(self : DshashperfectPath, v : Double) -> DshashperfectPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectPath::min(self : DshashperfectPath) -> Double { @_common.min(self.data) }

pub fn DshashperfectPath::max(self : DshashperfectPath) -> Double { @_common.max(self.data) }

pub fn DshashperfectPath::to_string(self : DshashperfectPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cluster_make(size : Int) -> DshashperfectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectCluster::len(self : DshashperfectCluster) -> Int { self.size }

pub fn DshashperfectCluster::get(self : DshashperfectCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectCluster::set(self : DshashperfectCluster, i : Int, v : Double) -> DshashperfectCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectCluster::sum(self : DshashperfectCluster) -> Double { @_common.sum(self.data) }

pub fn DshashperfectCluster::mean(self : DshashperfectCluster) -> Double { @_common.mean(self.data) }

pub fn DshashperfectCluster::scale(self : DshashperfectCluster, f : Double) -> DshashperfectCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectCluster::add(self : DshashperfectCluster, other : DshashperfectCluster) -> DshashperfectCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectCluster::copy(self : DshashperfectCluster) -> DshashperfectCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectCluster::fill(self : DshashperfectCluster, v : Double) -> DshashperfectCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectCluster::min(self : DshashperfectCluster) -> Double { @_common.min(self.data) }

pub fn DshashperfectCluster::max(self : DshashperfectCluster) -> Double { @_common.max(self.data) }

pub fn DshashperfectCluster::to_string(self : DshashperfectCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_model_make(size : Int) -> DshashperfectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectModel::len(self : DshashperfectModel) -> Int { self.size }

pub fn DshashperfectModel::get(self : DshashperfectModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectModel::set(self : DshashperfectModel, i : Int, v : Double) -> DshashperfectModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectModel::sum(self : DshashperfectModel) -> Double { @_common.sum(self.data) }

pub fn DshashperfectModel::mean(self : DshashperfectModel) -> Double { @_common.mean(self.data) }

pub fn DshashperfectModel::scale(self : DshashperfectModel, f : Double) -> DshashperfectModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectModel::add(self : DshashperfectModel, other : DshashperfectModel) -> DshashperfectModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectModel::copy(self : DshashperfectModel) -> DshashperfectModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectModel::fill(self : DshashperfectModel, v : Double) -> DshashperfectModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectModel::min(self : DshashperfectModel) -> Double { @_common.min(self.data) }

pub fn DshashperfectModel::max(self : DshashperfectModel) -> Double { @_common.max(self.data) }

pub fn DshashperfectModel::to_string(self : DshashperfectModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_layer_make(size : Int) -> DshashperfectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectLayer::len(self : DshashperfectLayer) -> Int { self.size }

pub fn DshashperfectLayer::get(self : DshashperfectLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectLayer::set(self : DshashperfectLayer, i : Int, v : Double) -> DshashperfectLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectLayer::sum(self : DshashperfectLayer) -> Double { @_common.sum(self.data) }

pub fn DshashperfectLayer::mean(self : DshashperfectLayer) -> Double { @_common.mean(self.data) }

pub fn DshashperfectLayer::scale(self : DshashperfectLayer, f : Double) -> DshashperfectLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectLayer::add(self : DshashperfectLayer, other : DshashperfectLayer) -> DshashperfectLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectLayer::copy(self : DshashperfectLayer) -> DshashperfectLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectLayer::fill(self : DshashperfectLayer, v : Double) -> DshashperfectLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectLayer::min(self : DshashperfectLayer) -> Double { @_common.min(self.data) }

pub fn DshashperfectLayer::max(self : DshashperfectLayer) -> Double { @_common.max(self.data) }

pub fn DshashperfectLayer::to_string(self : DshashperfectLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_buffer_make(size : Int) -> DshashperfectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectBuffer::len(self : DshashperfectBuffer) -> Int { self.size }

pub fn DshashperfectBuffer::get(self : DshashperfectBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectBuffer::set(self : DshashperfectBuffer, i : Int, v : Double) -> DshashperfectBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectBuffer::sum(self : DshashperfectBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashperfectBuffer::mean(self : DshashperfectBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashperfectBuffer::scale(self : DshashperfectBuffer, f : Double) -> DshashperfectBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectBuffer::add(self : DshashperfectBuffer, other : DshashperfectBuffer) -> DshashperfectBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectBuffer::copy(self : DshashperfectBuffer) -> DshashperfectBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectBuffer::fill(self : DshashperfectBuffer, v : Double) -> DshashperfectBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectBuffer::min(self : DshashperfectBuffer) -> Double { @_common.min(self.data) }

pub fn DshashperfectBuffer::max(self : DshashperfectBuffer) -> Double { @_common.max(self.data) }

pub fn DshashperfectBuffer::to_string(self : DshashperfectBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cursor_make(size : Int) -> DshashperfectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectCursor::len(self : DshashperfectCursor) -> Int { self.size }

pub fn DshashperfectCursor::get(self : DshashperfectCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectCursor::set(self : DshashperfectCursor, i : Int, v : Double) -> DshashperfectCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectCursor::sum(self : DshashperfectCursor) -> Double { @_common.sum(self.data) }

pub fn DshashperfectCursor::mean(self : DshashperfectCursor) -> Double { @_common.mean(self.data) }

pub fn DshashperfectCursor::scale(self : DshashperfectCursor, f : Double) -> DshashperfectCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectCursor::add(self : DshashperfectCursor, other : DshashperfectCursor) -> DshashperfectCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectCursor::copy(self : DshashperfectCursor) -> DshashperfectCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectCursor::fill(self : DshashperfectCursor, v : Double) -> DshashperfectCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectCursor::min(self : DshashperfectCursor) -> Double { @_common.min(self.data) }

pub fn DshashperfectCursor::max(self : DshashperfectCursor) -> Double { @_common.max(self.data) }

pub fn DshashperfectCursor::to_string(self : DshashperfectCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_view_make(size : Int) -> DshashperfectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectView::len(self : DshashperfectView) -> Int { self.size }

pub fn DshashperfectView::get(self : DshashperfectView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectView::set(self : DshashperfectView, i : Int, v : Double) -> DshashperfectView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectView::sum(self : DshashperfectView) -> Double { @_common.sum(self.data) }

pub fn DshashperfectView::mean(self : DshashperfectView) -> Double { @_common.mean(self.data) }

pub fn DshashperfectView::scale(self : DshashperfectView, f : Double) -> DshashperfectView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectView::add(self : DshashperfectView, other : DshashperfectView) -> DshashperfectView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectView::copy(self : DshashperfectView) -> DshashperfectView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectView::fill(self : DshashperfectView, v : Double) -> DshashperfectView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectView::min(self : DshashperfectView) -> Double { @_common.min(self.data) }

pub fn DshashperfectView::max(self : DshashperfectView) -> Double { @_common.max(self.data) }

pub fn DshashperfectView::to_string(self : DshashperfectView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_range_make(size : Int) -> DshashperfectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectRange::len(self : DshashperfectRange) -> Int { self.size }

pub fn DshashperfectRange::get(self : DshashperfectRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectRange::set(self : DshashperfectRange, i : Int, v : Double) -> DshashperfectRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectRange::sum(self : DshashperfectRange) -> Double { @_common.sum(self.data) }

pub fn DshashperfectRange::mean(self : DshashperfectRange) -> Double { @_common.mean(self.data) }

pub fn DshashperfectRange::scale(self : DshashperfectRange, f : Double) -> DshashperfectRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectRange::add(self : DshashperfectRange, other : DshashperfectRange) -> DshashperfectRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectRange::copy(self : DshashperfectRange) -> DshashperfectRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectRange::fill(self : DshashperfectRange, v : Double) -> DshashperfectRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectRange::min(self : DshashperfectRange) -> Double { @_common.min(self.data) }

pub fn DshashperfectRange::max(self : DshashperfectRange) -> Double { @_common.max(self.data) }

pub fn DshashperfectRange::to_string(self : DshashperfectRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashperfectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_slice_make(size : Int) -> DshashperfectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashperfectSlice::len(self : DshashperfectSlice) -> Int { self.size }

pub fn DshashperfectSlice::get(self : DshashperfectSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashperfectSlice::set(self : DshashperfectSlice, i : Int, v : Double) -> DshashperfectSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashperfectSlice::sum(self : DshashperfectSlice) -> Double { @_common.sum(self.data) }

pub fn DshashperfectSlice::mean(self : DshashperfectSlice) -> Double { @_common.mean(self.data) }

pub fn DshashperfectSlice::scale(self : DshashperfectSlice, f : Double) -> DshashperfectSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashperfectSlice::add(self : DshashperfectSlice, other : DshashperfectSlice) -> DshashperfectSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashperfectSlice::copy(self : DshashperfectSlice) -> DshashperfectSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashperfectSlice::fill(self : DshashperfectSlice, v : Double) -> DshashperfectSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashperfectSlice::min(self : DshashperfectSlice) -> Double { @_common.min(self.data) }

pub fn DshashperfectSlice::max(self : DshashperfectSlice) -> Double { @_common.max(self.data) }

pub fn DshashperfectSlice::to_string(self : DshashperfectSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

