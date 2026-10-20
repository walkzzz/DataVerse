///===
/// extcore/ds_list_lockfree

pub(all) struct DslistlockfreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_lockfree_make_point(x : Double, y : Double) -> DslistlockfreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_lockfree_make_point3(x : Double, y : Double, z : Double) -> DslistlockfreePoint {
  { x, y, z, label: 0 }
}

pub fn DslistlockfreePoint::x(self : DslistlockfreePoint) -> Double { self.x }

pub fn DslistlockfreePoint::y(self : DslistlockfreePoint) -> Double { self.y }

pub fn DslistlockfreePoint::z(self : DslistlockfreePoint) -> Double { self.z }

pub fn DslistlockfreePoint::label(self : DslistlockfreePoint) -> Int { self.label }

pub fn DslistlockfreePoint::dist(self : DslistlockfreePoint, other : DslistlockfreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistlockfreePoint::add(self : DslistlockfreePoint, other : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistlockfreePoint::sub(self : DslistlockfreePoint, other : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistlockfreePoint::scale(self : DslistlockfreePoint, s : Double) -> DslistlockfreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistlockfreePoint::dot(self : DslistlockfreePoint, other : DslistlockfreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistlockfreePoint::cross(self : DslistlockfreePoint, other : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistlockfreePoint::norm(self : DslistlockfreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistlockfreePoint::normalize(self : DslistlockfreePoint) -> DslistlockfreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistlockfreePoint::negate(self : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistlockfreePoint::mid(self : DslistlockfreePoint, other : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistlockfreePoint::lerp(self : DslistlockfreePoint, other : DslistlockfreePoint, t : Double) -> DslistlockfreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistlockfreePoint::to_string(self : DslistlockfreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistlockfreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_lockfree_make_series(vals : Array[Double], name : String) -> DslistlockfreeSeries {
  { vals, name, meta: 0 }
}

pub fn DslistlockfreeSeries::len(self : DslistlockfreeSeries) -> Int { self.vals.length() }

pub fn DslistlockfreeSeries::sum(self : DslistlockfreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistlockfreeSeries::mean(self : DslistlockfreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistlockfreeSeries::min(self : DslistlockfreeSeries) -> Double { @_common.min(self.vals) }

pub fn DslistlockfreeSeries::max(self : DslistlockfreeSeries) -> Double { @_common.max(self.vals) }

pub fn DslistlockfreeSeries::range(self : DslistlockfreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistlockfreeSeries::variance(self : DslistlockfreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistlockfreeSeries::std(self : DslistlockfreeSeries) -> Double { @_common.std(self.vals) }

pub fn DslistlockfreeSeries::median(self : DslistlockfreeSeries) -> Double { @_common.median(self.vals) }

pub fn DslistlockfreeSeries::scale(self : DslistlockfreeSeries, f : Double) -> DslistlockfreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistlockfreeSeries::add(self : DslistlockfreeSeries, other : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistlockfreeSeries::sub(self : DslistlockfreeSeries, other : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistlockfreeSeries::normalize(self : DslistlockfreeSeries) -> DslistlockfreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistlockfreeSeries::cumsum(self : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistlockfreeSeries::to_string(self : DslistlockfreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistlockfreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_lockfree_make_matrix(rows : Int, cols : Int, val : Double) -> DslistlockfreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_lockfree_matrix_identity(n : Int) -> DslistlockfreeMatrix {
  let m = ds_list_lockfree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistlockfreeMatrix::get(self : DslistlockfreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistlockfreeMatrix::transpose(self : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  let result = ds_list_lockfree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistlockfreeMatrix::add(self : DslistlockfreeMatrix, other : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_lockfree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistlockfreeMatrix::scale(self : DslistlockfreeMatrix, s : Double) -> DslistlockfreeMatrix {
  let result = ds_list_lockfree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistlockfreeMatrix::multiply(self : DslistlockfreeMatrix, other : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  if self.cols != other.rows { return ds_list_lockfree_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_lockfree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistlockfreeMatrix::trace(self : DslistlockfreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistlockfreeMatrix::det(self : DslistlockfreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistlockfreeMatrix::norm(self : DslistlockfreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistlockfreeMatrix::to_string(self : DslistlockfreeMatrix) -> String {
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

pub(all) struct DslistlockfreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_lockfree_make_vector(comps : Array[Double]) -> DslistlockfreeVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_lockfree_vector_zero(dim : Int) -> DslistlockfreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistlockfreeVector::add(self : DslistlockfreeVector, other : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistlockfreeVector::sub(self : DslistlockfreeVector, other : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistlockfreeVector::scale(self : DslistlockfreeVector, s : Double) -> DslistlockfreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistlockfreeVector::dot(self : DslistlockfreeVector, other : DslistlockfreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistlockfreeVector::norm(self : DslistlockfreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistlockfreeVector::normalize(self : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistlockfreeVector::dist(self : DslistlockfreeVector, other : DslistlockfreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistlockfreeVector::to_string(self : DslistlockfreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_lockfree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_lockfree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_lockfree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_lockfree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_lockfree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_lockfree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_lockfree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_lockfree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_lockfree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_lockfree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_lockfree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_lockfree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_lockfree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_lockfree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_lockfree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_lockfree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_lockfree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_lockfree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_lockfree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_lockfree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_lockfree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_lockfree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_lockfree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_lockfree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_lockfree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_lockfree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_lockfree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_lockfree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_lockfree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistlockfreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_frame_make(size : Int) -> DslistlockfreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeFrame::len(self : DslistlockfreeFrame) -> Int { self.size }

pub fn DslistlockfreeFrame::get(self : DslistlockfreeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeFrame::set(self : DslistlockfreeFrame, i : Int, v : Double) -> DslistlockfreeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeFrame::sum(self : DslistlockfreeFrame) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeFrame::mean(self : DslistlockfreeFrame) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeFrame::scale(self : DslistlockfreeFrame, f : Double) -> DslistlockfreeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeFrame::add(self : DslistlockfreeFrame, other : DslistlockfreeFrame) -> DslistlockfreeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeFrame::copy(self : DslistlockfreeFrame) -> DslistlockfreeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeFrame::fill(self : DslistlockfreeFrame, v : Double) -> DslistlockfreeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeFrame::min(self : DslistlockfreeFrame) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeFrame::max(self : DslistlockfreeFrame) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeFrame::to_string(self : DslistlockfreeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_table_make(size : Int) -> DslistlockfreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeTable::len(self : DslistlockfreeTable) -> Int { self.size }

pub fn DslistlockfreeTable::get(self : DslistlockfreeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeTable::set(self : DslistlockfreeTable, i : Int, v : Double) -> DslistlockfreeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeTable::sum(self : DslistlockfreeTable) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeTable::mean(self : DslistlockfreeTable) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeTable::scale(self : DslistlockfreeTable, f : Double) -> DslistlockfreeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeTable::add(self : DslistlockfreeTable, other : DslistlockfreeTable) -> DslistlockfreeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeTable::copy(self : DslistlockfreeTable) -> DslistlockfreeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeTable::fill(self : DslistlockfreeTable, v : Double) -> DslistlockfreeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeTable::min(self : DslistlockfreeTable) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeTable::max(self : DslistlockfreeTable) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeTable::to_string(self : DslistlockfreeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_graphn_make(size : Int) -> DslistlockfreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeGraphN::len(self : DslistlockfreeGraphN) -> Int { self.size }

pub fn DslistlockfreeGraphN::get(self : DslistlockfreeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeGraphN::set(self : DslistlockfreeGraphN, i : Int, v : Double) -> DslistlockfreeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeGraphN::sum(self : DslistlockfreeGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeGraphN::mean(self : DslistlockfreeGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeGraphN::scale(self : DslistlockfreeGraphN, f : Double) -> DslistlockfreeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeGraphN::add(self : DslistlockfreeGraphN, other : DslistlockfreeGraphN) -> DslistlockfreeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeGraphN::copy(self : DslistlockfreeGraphN) -> DslistlockfreeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeGraphN::fill(self : DslistlockfreeGraphN, v : Double) -> DslistlockfreeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeGraphN::min(self : DslistlockfreeGraphN) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeGraphN::max(self : DslistlockfreeGraphN) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeGraphN::to_string(self : DslistlockfreeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_node_make(size : Int) -> DslistlockfreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeNode::len(self : DslistlockfreeNode) -> Int { self.size }

pub fn DslistlockfreeNode::get(self : DslistlockfreeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeNode::set(self : DslistlockfreeNode, i : Int, v : Double) -> DslistlockfreeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeNode::sum(self : DslistlockfreeNode) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeNode::mean(self : DslistlockfreeNode) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeNode::scale(self : DslistlockfreeNode, f : Double) -> DslistlockfreeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeNode::add(self : DslistlockfreeNode, other : DslistlockfreeNode) -> DslistlockfreeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeNode::copy(self : DslistlockfreeNode) -> DslistlockfreeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeNode::fill(self : DslistlockfreeNode, v : Double) -> DslistlockfreeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeNode::min(self : DslistlockfreeNode) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeNode::max(self : DslistlockfreeNode) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeNode::to_string(self : DslistlockfreeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_edge_make(size : Int) -> DslistlockfreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeEdge::len(self : DslistlockfreeEdge) -> Int { self.size }

pub fn DslistlockfreeEdge::get(self : DslistlockfreeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeEdge::set(self : DslistlockfreeEdge, i : Int, v : Double) -> DslistlockfreeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeEdge::sum(self : DslistlockfreeEdge) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeEdge::mean(self : DslistlockfreeEdge) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeEdge::scale(self : DslistlockfreeEdge, f : Double) -> DslistlockfreeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeEdge::add(self : DslistlockfreeEdge, other : DslistlockfreeEdge) -> DslistlockfreeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeEdge::copy(self : DslistlockfreeEdge) -> DslistlockfreeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeEdge::fill(self : DslistlockfreeEdge, v : Double) -> DslistlockfreeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeEdge::min(self : DslistlockfreeEdge) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeEdge::max(self : DslistlockfreeEdge) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeEdge::to_string(self : DslistlockfreeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_path_make(size : Int) -> DslistlockfreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreePath::len(self : DslistlockfreePath) -> Int { self.size }

pub fn DslistlockfreePath::get(self : DslistlockfreePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreePath::set(self : DslistlockfreePath, i : Int, v : Double) -> DslistlockfreePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreePath::sum(self : DslistlockfreePath) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreePath::mean(self : DslistlockfreePath) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreePath::scale(self : DslistlockfreePath, f : Double) -> DslistlockfreePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreePath::add(self : DslistlockfreePath, other : DslistlockfreePath) -> DslistlockfreePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreePath::copy(self : DslistlockfreePath) -> DslistlockfreePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreePath::fill(self : DslistlockfreePath, v : Double) -> DslistlockfreePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreePath::min(self : DslistlockfreePath) -> Double { @_common.min(self.data) }

pub fn DslistlockfreePath::max(self : DslistlockfreePath) -> Double { @_common.max(self.data) }

pub fn DslistlockfreePath::to_string(self : DslistlockfreePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_cluster_make(size : Int) -> DslistlockfreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeCluster::len(self : DslistlockfreeCluster) -> Int { self.size }

pub fn DslistlockfreeCluster::get(self : DslistlockfreeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeCluster::set(self : DslistlockfreeCluster, i : Int, v : Double) -> DslistlockfreeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCluster::sum(self : DslistlockfreeCluster) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeCluster::mean(self : DslistlockfreeCluster) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeCluster::scale(self : DslistlockfreeCluster, f : Double) -> DslistlockfreeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCluster::add(self : DslistlockfreeCluster, other : DslistlockfreeCluster) -> DslistlockfreeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeCluster::copy(self : DslistlockfreeCluster) -> DslistlockfreeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCluster::fill(self : DslistlockfreeCluster, v : Double) -> DslistlockfreeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCluster::min(self : DslistlockfreeCluster) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeCluster::max(self : DslistlockfreeCluster) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeCluster::to_string(self : DslistlockfreeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_model_make(size : Int) -> DslistlockfreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeModel::len(self : DslistlockfreeModel) -> Int { self.size }

pub fn DslistlockfreeModel::get(self : DslistlockfreeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeModel::set(self : DslistlockfreeModel, i : Int, v : Double) -> DslistlockfreeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeModel::sum(self : DslistlockfreeModel) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeModel::mean(self : DslistlockfreeModel) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeModel::scale(self : DslistlockfreeModel, f : Double) -> DslistlockfreeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeModel::add(self : DslistlockfreeModel, other : DslistlockfreeModel) -> DslistlockfreeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeModel::copy(self : DslistlockfreeModel) -> DslistlockfreeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeModel::fill(self : DslistlockfreeModel, v : Double) -> DslistlockfreeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeModel::min(self : DslistlockfreeModel) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeModel::max(self : DslistlockfreeModel) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeModel::to_string(self : DslistlockfreeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_layer_make(size : Int) -> DslistlockfreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeLayer::len(self : DslistlockfreeLayer) -> Int { self.size }

pub fn DslistlockfreeLayer::get(self : DslistlockfreeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeLayer::set(self : DslistlockfreeLayer, i : Int, v : Double) -> DslistlockfreeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeLayer::sum(self : DslistlockfreeLayer) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeLayer::mean(self : DslistlockfreeLayer) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeLayer::scale(self : DslistlockfreeLayer, f : Double) -> DslistlockfreeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeLayer::add(self : DslistlockfreeLayer, other : DslistlockfreeLayer) -> DslistlockfreeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeLayer::copy(self : DslistlockfreeLayer) -> DslistlockfreeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeLayer::fill(self : DslistlockfreeLayer, v : Double) -> DslistlockfreeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeLayer::min(self : DslistlockfreeLayer) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeLayer::max(self : DslistlockfreeLayer) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeLayer::to_string(self : DslistlockfreeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_buffer_make(size : Int) -> DslistlockfreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeBuffer::len(self : DslistlockfreeBuffer) -> Int { self.size }

pub fn DslistlockfreeBuffer::get(self : DslistlockfreeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeBuffer::set(self : DslistlockfreeBuffer, i : Int, v : Double) -> DslistlockfreeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeBuffer::sum(self : DslistlockfreeBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeBuffer::mean(self : DslistlockfreeBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeBuffer::scale(self : DslistlockfreeBuffer, f : Double) -> DslistlockfreeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeBuffer::add(self : DslistlockfreeBuffer, other : DslistlockfreeBuffer) -> DslistlockfreeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeBuffer::copy(self : DslistlockfreeBuffer) -> DslistlockfreeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeBuffer::fill(self : DslistlockfreeBuffer, v : Double) -> DslistlockfreeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeBuffer::min(self : DslistlockfreeBuffer) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeBuffer::max(self : DslistlockfreeBuffer) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeBuffer::to_string(self : DslistlockfreeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_cursor_make(size : Int) -> DslistlockfreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeCursor::len(self : DslistlockfreeCursor) -> Int { self.size }

pub fn DslistlockfreeCursor::get(self : DslistlockfreeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeCursor::set(self : DslistlockfreeCursor, i : Int, v : Double) -> DslistlockfreeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCursor::sum(self : DslistlockfreeCursor) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeCursor::mean(self : DslistlockfreeCursor) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeCursor::scale(self : DslistlockfreeCursor, f : Double) -> DslistlockfreeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCursor::add(self : DslistlockfreeCursor, other : DslistlockfreeCursor) -> DslistlockfreeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeCursor::copy(self : DslistlockfreeCursor) -> DslistlockfreeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCursor::fill(self : DslistlockfreeCursor, v : Double) -> DslistlockfreeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeCursor::min(self : DslistlockfreeCursor) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeCursor::max(self : DslistlockfreeCursor) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeCursor::to_string(self : DslistlockfreeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_view_make(size : Int) -> DslistlockfreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeView::len(self : DslistlockfreeView) -> Int { self.size }

pub fn DslistlockfreeView::get(self : DslistlockfreeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeView::set(self : DslistlockfreeView, i : Int, v : Double) -> DslistlockfreeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeView::sum(self : DslistlockfreeView) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeView::mean(self : DslistlockfreeView) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeView::scale(self : DslistlockfreeView, f : Double) -> DslistlockfreeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeView::add(self : DslistlockfreeView, other : DslistlockfreeView) -> DslistlockfreeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeView::copy(self : DslistlockfreeView) -> DslistlockfreeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeView::fill(self : DslistlockfreeView, v : Double) -> DslistlockfreeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeView::min(self : DslistlockfreeView) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeView::max(self : DslistlockfreeView) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeView::to_string(self : DslistlockfreeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_range_make(size : Int) -> DslistlockfreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeRange::len(self : DslistlockfreeRange) -> Int { self.size }

pub fn DslistlockfreeRange::get(self : DslistlockfreeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeRange::set(self : DslistlockfreeRange, i : Int, v : Double) -> DslistlockfreeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeRange::sum(self : DslistlockfreeRange) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeRange::mean(self : DslistlockfreeRange) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeRange::scale(self : DslistlockfreeRange, f : Double) -> DslistlockfreeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeRange::add(self : DslistlockfreeRange, other : DslistlockfreeRange) -> DslistlockfreeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeRange::copy(self : DslistlockfreeRange) -> DslistlockfreeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeRange::fill(self : DslistlockfreeRange, v : Double) -> DslistlockfreeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeRange::min(self : DslistlockfreeRange) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeRange::max(self : DslistlockfreeRange) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeRange::to_string(self : DslistlockfreeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_slice_make(size : Int) -> DslistlockfreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistlockfreeSlice::len(self : DslistlockfreeSlice) -> Int { self.size }

pub fn DslistlockfreeSlice::get(self : DslistlockfreeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistlockfreeSlice::set(self : DslistlockfreeSlice, i : Int, v : Double) -> DslistlockfreeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistlockfreeSlice::sum(self : DslistlockfreeSlice) -> Double { @_common.sum(self.data) }

pub fn DslistlockfreeSlice::mean(self : DslistlockfreeSlice) -> Double { @_common.mean(self.data) }

pub fn DslistlockfreeSlice::scale(self : DslistlockfreeSlice, f : Double) -> DslistlockfreeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeSlice::add(self : DslistlockfreeSlice, other : DslistlockfreeSlice) -> DslistlockfreeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistlockfreeSlice::copy(self : DslistlockfreeSlice) -> DslistlockfreeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeSlice::fill(self : DslistlockfreeSlice, v : Double) -> DslistlockfreeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistlockfreeSlice::min(self : DslistlockfreeSlice) -> Double { @_common.min(self.data) }

pub fn DslistlockfreeSlice::max(self : DslistlockfreeSlice) -> Double { @_common.max(self.data) }

pub fn DslistlockfreeSlice::to_string(self : DslistlockfreeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

