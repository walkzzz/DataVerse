///===
/// extcore/graph_tree_mst_prim

pub(all) struct GraphtreemstprimPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_prim_make_point(x : Double, y : Double) -> GraphtreemstprimPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_prim_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstprimPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreemstprimPoint::x(self : GraphtreemstprimPoint) -> Double { self.x }

pub fn GraphtreemstprimPoint::y(self : GraphtreemstprimPoint) -> Double { self.y }

pub fn GraphtreemstprimPoint::z(self : GraphtreemstprimPoint) -> Double { self.z }

pub fn GraphtreemstprimPoint::label(self : GraphtreemstprimPoint) -> Int { self.label }

pub fn GraphtreemstprimPoint::dist(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreemstprimPoint::add(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreemstprimPoint::sub(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreemstprimPoint::scale(self : GraphtreemstprimPoint, s : Double) -> GraphtreemstprimPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreemstprimPoint::dot(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreemstprimPoint::cross(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreemstprimPoint::norm(self : GraphtreemstprimPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreemstprimPoint::normalize(self : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstprimPoint::negate(self : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreemstprimPoint::mid(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreemstprimPoint::lerp(self : GraphtreemstprimPoint, other : GraphtreemstprimPoint, t : Double) -> GraphtreemstprimPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreemstprimPoint::to_string(self : GraphtreemstprimPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreemstprimSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_prim_make_series(vals : Array[Double], name : String) -> GraphtreemstprimSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreemstprimSeries::len(self : GraphtreemstprimSeries) -> Int { self.vals.length() }

pub fn GraphtreemstprimSeries::sum(self : GraphtreemstprimSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreemstprimSeries::mean(self : GraphtreemstprimSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreemstprimSeries::min(self : GraphtreemstprimSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreemstprimSeries::max(self : GraphtreemstprimSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreemstprimSeries::range(self : GraphtreemstprimSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreemstprimSeries::variance(self : GraphtreemstprimSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreemstprimSeries::std(self : GraphtreemstprimSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreemstprimSeries::median(self : GraphtreemstprimSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreemstprimSeries::scale(self : GraphtreemstprimSeries, f : Double) -> GraphtreemstprimSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreemstprimSeries::add(self : GraphtreemstprimSeries, other : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreemstprimSeries::sub(self : GraphtreemstprimSeries, other : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreemstprimSeries::normalize(self : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreemstprimSeries::cumsum(self : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreemstprimSeries::to_string(self : GraphtreemstprimSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstprimMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_prim_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstprimMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_prim_matrix_identity(n : Int) -> GraphtreemstprimMatrix {
  let m = graph_tree_mst_prim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreemstprimMatrix::get(self : GraphtreemstprimMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreemstprimMatrix::transpose(self : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  let result = graph_tree_mst_prim_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreemstprimMatrix::add(self : GraphtreemstprimMatrix, other : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_mst_prim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreemstprimMatrix::scale(self : GraphtreemstprimMatrix, s : Double) -> GraphtreemstprimMatrix {
  let result = graph_tree_mst_prim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreemstprimMatrix::multiply(self : GraphtreemstprimMatrix, other : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  if self.cols != other.rows { return graph_tree_mst_prim_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_mst_prim_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreemstprimMatrix::trace(self : GraphtreemstprimMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreemstprimMatrix::det(self : GraphtreemstprimMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreemstprimMatrix::norm(self : GraphtreemstprimMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreemstprimMatrix::to_string(self : GraphtreemstprimMatrix) -> String {
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

pub(all) struct GraphtreemstprimVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_prim_make_vector(comps : Array[Double]) -> GraphtreemstprimVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_prim_vector_zero(dim : Int) -> GraphtreemstprimVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreemstprimVector::add(self : GraphtreemstprimVector, other : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstprimVector::sub(self : GraphtreemstprimVector, other : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstprimVector::scale(self : GraphtreemstprimVector, s : Double) -> GraphtreemstprimVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreemstprimVector::dot(self : GraphtreemstprimVector, other : GraphtreemstprimVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreemstprimVector::norm(self : GraphtreemstprimVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreemstprimVector::normalize(self : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstprimVector::dist(self : GraphtreemstprimVector, other : GraphtreemstprimVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreemstprimVector::to_string(self : GraphtreemstprimVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_prim_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_prim_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_prim_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_prim_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_prim_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_prim_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_prim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_prim_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_prim_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_prim_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_prim_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_prim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_prim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_prim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_prim_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_prim_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_prim_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_prim_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_prim_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_prim_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_prim_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_prim_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_prim_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_prim_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_prim_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_prim_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_prim_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_prim_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_prim_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstprimFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_frame_make(size : Int) -> GraphtreemstprimFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimFrame::len(self : GraphtreemstprimFrame) -> Int { self.size }

pub fn GraphtreemstprimFrame::get(self : GraphtreemstprimFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimFrame::set(self : GraphtreemstprimFrame, i : Int, v : Double) -> GraphtreemstprimFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimFrame::sum(self : GraphtreemstprimFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimFrame::mean(self : GraphtreemstprimFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimFrame::scale(self : GraphtreemstprimFrame, f : Double) -> GraphtreemstprimFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimFrame::add(self : GraphtreemstprimFrame, other : GraphtreemstprimFrame) -> GraphtreemstprimFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimFrame::copy(self : GraphtreemstprimFrame) -> GraphtreemstprimFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimFrame::fill(self : GraphtreemstprimFrame, v : Double) -> GraphtreemstprimFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimFrame::min(self : GraphtreemstprimFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimFrame::max(self : GraphtreemstprimFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimFrame::to_string(self : GraphtreemstprimFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_table_make(size : Int) -> GraphtreemstprimTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimTable::len(self : GraphtreemstprimTable) -> Int { self.size }

pub fn GraphtreemstprimTable::get(self : GraphtreemstprimTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimTable::set(self : GraphtreemstprimTable, i : Int, v : Double) -> GraphtreemstprimTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimTable::sum(self : GraphtreemstprimTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimTable::mean(self : GraphtreemstprimTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimTable::scale(self : GraphtreemstprimTable, f : Double) -> GraphtreemstprimTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimTable::add(self : GraphtreemstprimTable, other : GraphtreemstprimTable) -> GraphtreemstprimTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimTable::copy(self : GraphtreemstprimTable) -> GraphtreemstprimTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimTable::fill(self : GraphtreemstprimTable, v : Double) -> GraphtreemstprimTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimTable::min(self : GraphtreemstprimTable) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimTable::max(self : GraphtreemstprimTable) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimTable::to_string(self : GraphtreemstprimTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_graphn_make(size : Int) -> GraphtreemstprimGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimGraphN::len(self : GraphtreemstprimGraphN) -> Int { self.size }

pub fn GraphtreemstprimGraphN::get(self : GraphtreemstprimGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimGraphN::set(self : GraphtreemstprimGraphN, i : Int, v : Double) -> GraphtreemstprimGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimGraphN::sum(self : GraphtreemstprimGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimGraphN::mean(self : GraphtreemstprimGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimGraphN::scale(self : GraphtreemstprimGraphN, f : Double) -> GraphtreemstprimGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimGraphN::add(self : GraphtreemstprimGraphN, other : GraphtreemstprimGraphN) -> GraphtreemstprimGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimGraphN::copy(self : GraphtreemstprimGraphN) -> GraphtreemstprimGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimGraphN::fill(self : GraphtreemstprimGraphN, v : Double) -> GraphtreemstprimGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimGraphN::min(self : GraphtreemstprimGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimGraphN::max(self : GraphtreemstprimGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimGraphN::to_string(self : GraphtreemstprimGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_node_make(size : Int) -> GraphtreemstprimNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimNode::len(self : GraphtreemstprimNode) -> Int { self.size }

pub fn GraphtreemstprimNode::get(self : GraphtreemstprimNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimNode::set(self : GraphtreemstprimNode, i : Int, v : Double) -> GraphtreemstprimNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimNode::sum(self : GraphtreemstprimNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimNode::mean(self : GraphtreemstprimNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimNode::scale(self : GraphtreemstprimNode, f : Double) -> GraphtreemstprimNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimNode::add(self : GraphtreemstprimNode, other : GraphtreemstprimNode) -> GraphtreemstprimNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimNode::copy(self : GraphtreemstprimNode) -> GraphtreemstprimNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimNode::fill(self : GraphtreemstprimNode, v : Double) -> GraphtreemstprimNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimNode::min(self : GraphtreemstprimNode) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimNode::max(self : GraphtreemstprimNode) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimNode::to_string(self : GraphtreemstprimNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_edge_make(size : Int) -> GraphtreemstprimEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimEdge::len(self : GraphtreemstprimEdge) -> Int { self.size }

pub fn GraphtreemstprimEdge::get(self : GraphtreemstprimEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimEdge::set(self : GraphtreemstprimEdge, i : Int, v : Double) -> GraphtreemstprimEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimEdge::sum(self : GraphtreemstprimEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimEdge::mean(self : GraphtreemstprimEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimEdge::scale(self : GraphtreemstprimEdge, f : Double) -> GraphtreemstprimEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimEdge::add(self : GraphtreemstprimEdge, other : GraphtreemstprimEdge) -> GraphtreemstprimEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimEdge::copy(self : GraphtreemstprimEdge) -> GraphtreemstprimEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimEdge::fill(self : GraphtreemstprimEdge, v : Double) -> GraphtreemstprimEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimEdge::min(self : GraphtreemstprimEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimEdge::max(self : GraphtreemstprimEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimEdge::to_string(self : GraphtreemstprimEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_path_make(size : Int) -> GraphtreemstprimPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimPath::len(self : GraphtreemstprimPath) -> Int { self.size }

pub fn GraphtreemstprimPath::get(self : GraphtreemstprimPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimPath::set(self : GraphtreemstprimPath, i : Int, v : Double) -> GraphtreemstprimPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimPath::sum(self : GraphtreemstprimPath) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimPath::mean(self : GraphtreemstprimPath) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimPath::scale(self : GraphtreemstprimPath, f : Double) -> GraphtreemstprimPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimPath::add(self : GraphtreemstprimPath, other : GraphtreemstprimPath) -> GraphtreemstprimPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimPath::copy(self : GraphtreemstprimPath) -> GraphtreemstprimPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimPath::fill(self : GraphtreemstprimPath, v : Double) -> GraphtreemstprimPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimPath::min(self : GraphtreemstprimPath) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimPath::max(self : GraphtreemstprimPath) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimPath::to_string(self : GraphtreemstprimPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_cluster_make(size : Int) -> GraphtreemstprimCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimCluster::len(self : GraphtreemstprimCluster) -> Int { self.size }

pub fn GraphtreemstprimCluster::get(self : GraphtreemstprimCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimCluster::set(self : GraphtreemstprimCluster, i : Int, v : Double) -> GraphtreemstprimCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCluster::sum(self : GraphtreemstprimCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimCluster::mean(self : GraphtreemstprimCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimCluster::scale(self : GraphtreemstprimCluster, f : Double) -> GraphtreemstprimCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCluster::add(self : GraphtreemstprimCluster, other : GraphtreemstprimCluster) -> GraphtreemstprimCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimCluster::copy(self : GraphtreemstprimCluster) -> GraphtreemstprimCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCluster::fill(self : GraphtreemstprimCluster, v : Double) -> GraphtreemstprimCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCluster::min(self : GraphtreemstprimCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimCluster::max(self : GraphtreemstprimCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimCluster::to_string(self : GraphtreemstprimCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_model_make(size : Int) -> GraphtreemstprimModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimModel::len(self : GraphtreemstprimModel) -> Int { self.size }

pub fn GraphtreemstprimModel::get(self : GraphtreemstprimModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimModel::set(self : GraphtreemstprimModel, i : Int, v : Double) -> GraphtreemstprimModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimModel::sum(self : GraphtreemstprimModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimModel::mean(self : GraphtreemstprimModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimModel::scale(self : GraphtreemstprimModel, f : Double) -> GraphtreemstprimModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimModel::add(self : GraphtreemstprimModel, other : GraphtreemstprimModel) -> GraphtreemstprimModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimModel::copy(self : GraphtreemstprimModel) -> GraphtreemstprimModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimModel::fill(self : GraphtreemstprimModel, v : Double) -> GraphtreemstprimModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimModel::min(self : GraphtreemstprimModel) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimModel::max(self : GraphtreemstprimModel) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimModel::to_string(self : GraphtreemstprimModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_layer_make(size : Int) -> GraphtreemstprimLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimLayer::len(self : GraphtreemstprimLayer) -> Int { self.size }

pub fn GraphtreemstprimLayer::get(self : GraphtreemstprimLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimLayer::set(self : GraphtreemstprimLayer, i : Int, v : Double) -> GraphtreemstprimLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimLayer::sum(self : GraphtreemstprimLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimLayer::mean(self : GraphtreemstprimLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimLayer::scale(self : GraphtreemstprimLayer, f : Double) -> GraphtreemstprimLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimLayer::add(self : GraphtreemstprimLayer, other : GraphtreemstprimLayer) -> GraphtreemstprimLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimLayer::copy(self : GraphtreemstprimLayer) -> GraphtreemstprimLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimLayer::fill(self : GraphtreemstprimLayer, v : Double) -> GraphtreemstprimLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimLayer::min(self : GraphtreemstprimLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimLayer::max(self : GraphtreemstprimLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimLayer::to_string(self : GraphtreemstprimLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_buffer_make(size : Int) -> GraphtreemstprimBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimBuffer::len(self : GraphtreemstprimBuffer) -> Int { self.size }

pub fn GraphtreemstprimBuffer::get(self : GraphtreemstprimBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimBuffer::set(self : GraphtreemstprimBuffer, i : Int, v : Double) -> GraphtreemstprimBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimBuffer::sum(self : GraphtreemstprimBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimBuffer::mean(self : GraphtreemstprimBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimBuffer::scale(self : GraphtreemstprimBuffer, f : Double) -> GraphtreemstprimBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimBuffer::add(self : GraphtreemstprimBuffer, other : GraphtreemstprimBuffer) -> GraphtreemstprimBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimBuffer::copy(self : GraphtreemstprimBuffer) -> GraphtreemstprimBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimBuffer::fill(self : GraphtreemstprimBuffer, v : Double) -> GraphtreemstprimBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimBuffer::min(self : GraphtreemstprimBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimBuffer::max(self : GraphtreemstprimBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimBuffer::to_string(self : GraphtreemstprimBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_cursor_make(size : Int) -> GraphtreemstprimCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimCursor::len(self : GraphtreemstprimCursor) -> Int { self.size }

pub fn GraphtreemstprimCursor::get(self : GraphtreemstprimCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimCursor::set(self : GraphtreemstprimCursor, i : Int, v : Double) -> GraphtreemstprimCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCursor::sum(self : GraphtreemstprimCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimCursor::mean(self : GraphtreemstprimCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimCursor::scale(self : GraphtreemstprimCursor, f : Double) -> GraphtreemstprimCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCursor::add(self : GraphtreemstprimCursor, other : GraphtreemstprimCursor) -> GraphtreemstprimCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimCursor::copy(self : GraphtreemstprimCursor) -> GraphtreemstprimCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCursor::fill(self : GraphtreemstprimCursor, v : Double) -> GraphtreemstprimCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimCursor::min(self : GraphtreemstprimCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimCursor::max(self : GraphtreemstprimCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimCursor::to_string(self : GraphtreemstprimCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_view_make(size : Int) -> GraphtreemstprimView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimView::len(self : GraphtreemstprimView) -> Int { self.size }

pub fn GraphtreemstprimView::get(self : GraphtreemstprimView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimView::set(self : GraphtreemstprimView, i : Int, v : Double) -> GraphtreemstprimView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimView::sum(self : GraphtreemstprimView) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimView::mean(self : GraphtreemstprimView) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimView::scale(self : GraphtreemstprimView, f : Double) -> GraphtreemstprimView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimView::add(self : GraphtreemstprimView, other : GraphtreemstprimView) -> GraphtreemstprimView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimView::copy(self : GraphtreemstprimView) -> GraphtreemstprimView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimView::fill(self : GraphtreemstprimView, v : Double) -> GraphtreemstprimView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimView::min(self : GraphtreemstprimView) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimView::max(self : GraphtreemstprimView) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimView::to_string(self : GraphtreemstprimView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_range_make(size : Int) -> GraphtreemstprimRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimRange::len(self : GraphtreemstprimRange) -> Int { self.size }

pub fn GraphtreemstprimRange::get(self : GraphtreemstprimRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimRange::set(self : GraphtreemstprimRange, i : Int, v : Double) -> GraphtreemstprimRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimRange::sum(self : GraphtreemstprimRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimRange::mean(self : GraphtreemstprimRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimRange::scale(self : GraphtreemstprimRange, f : Double) -> GraphtreemstprimRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimRange::add(self : GraphtreemstprimRange, other : GraphtreemstprimRange) -> GraphtreemstprimRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimRange::copy(self : GraphtreemstprimRange) -> GraphtreemstprimRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimRange::fill(self : GraphtreemstprimRange, v : Double) -> GraphtreemstprimRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimRange::min(self : GraphtreemstprimRange) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimRange::max(self : GraphtreemstprimRange) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimRange::to_string(self : GraphtreemstprimRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_slice_make(size : Int) -> GraphtreemstprimSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstprimSlice::len(self : GraphtreemstprimSlice) -> Int { self.size }

pub fn GraphtreemstprimSlice::get(self : GraphtreemstprimSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstprimSlice::set(self : GraphtreemstprimSlice, i : Int, v : Double) -> GraphtreemstprimSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimSlice::sum(self : GraphtreemstprimSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstprimSlice::mean(self : GraphtreemstprimSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstprimSlice::scale(self : GraphtreemstprimSlice, f : Double) -> GraphtreemstprimSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimSlice::add(self : GraphtreemstprimSlice, other : GraphtreemstprimSlice) -> GraphtreemstprimSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstprimSlice::copy(self : GraphtreemstprimSlice) -> GraphtreemstprimSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimSlice::fill(self : GraphtreemstprimSlice, v : Double) -> GraphtreemstprimSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstprimSlice::min(self : GraphtreemstprimSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreemstprimSlice::max(self : GraphtreemstprimSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreemstprimSlice::to_string(self : GraphtreemstprimSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

