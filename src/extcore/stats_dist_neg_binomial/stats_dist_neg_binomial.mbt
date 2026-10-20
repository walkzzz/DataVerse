///===
/// extcore/stats_dist_neg_binomial

pub(all) struct StatsdistnegbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_neg_binomial_make_point(x : Double, y : Double) -> StatsdistnegbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_neg_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistnegbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistnegbinomialPoint::x(self : StatsdistnegbinomialPoint) -> Double { self.x }

pub fn StatsdistnegbinomialPoint::y(self : StatsdistnegbinomialPoint) -> Double { self.y }

pub fn StatsdistnegbinomialPoint::z(self : StatsdistnegbinomialPoint) -> Double { self.z }

pub fn StatsdistnegbinomialPoint::label(self : StatsdistnegbinomialPoint) -> Int { self.label }

pub fn StatsdistnegbinomialPoint::dist(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistnegbinomialPoint::add(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::sub(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::scale(self : StatsdistnegbinomialPoint, s : Double) -> StatsdistnegbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistnegbinomialPoint::dot(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistnegbinomialPoint::cross(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistnegbinomialPoint::norm(self : StatsdistnegbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistnegbinomialPoint::normalize(self : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnegbinomialPoint::negate(self : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::mid(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistnegbinomialPoint::lerp(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint, t : Double) -> StatsdistnegbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistnegbinomialPoint::to_string(self : StatsdistnegbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_neg_binomial_make_series(vals : Array[Double], name : String) -> StatsdistnegbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistnegbinomialSeries::len(self : StatsdistnegbinomialSeries) -> Int { self.vals.length() }

pub fn StatsdistnegbinomialSeries::sum(self : StatsdistnegbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistnegbinomialSeries::mean(self : StatsdistnegbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistnegbinomialSeries::min(self : StatsdistnegbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistnegbinomialSeries::max(self : StatsdistnegbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistnegbinomialSeries::range(self : StatsdistnegbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistnegbinomialSeries::variance(self : StatsdistnegbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistnegbinomialSeries::std(self : StatsdistnegbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistnegbinomialSeries::median(self : StatsdistnegbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistnegbinomialSeries::scale(self : StatsdistnegbinomialSeries, f : Double) -> StatsdistnegbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::add(self : StatsdistnegbinomialSeries, other : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::sub(self : StatsdistnegbinomialSeries, other : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::normalize(self : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistnegbinomialSeries::cumsum(self : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::to_string(self : StatsdistnegbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnegbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_neg_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnegbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_neg_binomial_matrix_identity(n : Int) -> StatsdistnegbinomialMatrix {
  let m = stats_dist_neg_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistnegbinomialMatrix::get(self : StatsdistnegbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistnegbinomialMatrix::transpose(self : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistnegbinomialMatrix::add(self : StatsdistnegbinomialMatrix, other : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_neg_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistnegbinomialMatrix::scale(self : StatsdistnegbinomialMatrix, s : Double) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistnegbinomialMatrix::multiply(self : StatsdistnegbinomialMatrix, other : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if self.cols != other.rows { return stats_dist_neg_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_neg_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistnegbinomialMatrix::trace(self : StatsdistnegbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistnegbinomialMatrix::det(self : StatsdistnegbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistnegbinomialMatrix::norm(self : StatsdistnegbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistnegbinomialMatrix::to_string(self : StatsdistnegbinomialMatrix) -> String {
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

pub(all) struct StatsdistnegbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_neg_binomial_make_vector(comps : Array[Double]) -> StatsdistnegbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_neg_binomial_vector_zero(dim : Int) -> StatsdistnegbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistnegbinomialVector::add(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnegbinomialVector::sub(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnegbinomialVector::scale(self : StatsdistnegbinomialVector, s : Double) -> StatsdistnegbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistnegbinomialVector::dot(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistnegbinomialVector::norm(self : StatsdistnegbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistnegbinomialVector::normalize(self : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnegbinomialVector::dist(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistnegbinomialVector::to_string(self : StatsdistnegbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnegbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_frame_make(size : Int) -> StatsdistnegbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialFrame::len(self : StatsdistnegbinomialFrame) -> Int { self.size }

pub fn StatsdistnegbinomialFrame::get(self : StatsdistnegbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialFrame::set(self : StatsdistnegbinomialFrame, i : Int, v : Double) -> StatsdistnegbinomialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialFrame::sum(self : StatsdistnegbinomialFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialFrame::mean(self : StatsdistnegbinomialFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialFrame::scale(self : StatsdistnegbinomialFrame, f : Double) -> StatsdistnegbinomialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialFrame::add(self : StatsdistnegbinomialFrame, other : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialFrame::copy(self : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialFrame::fill(self : StatsdistnegbinomialFrame, v : Double) -> StatsdistnegbinomialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialFrame::min(self : StatsdistnegbinomialFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialFrame::max(self : StatsdistnegbinomialFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialFrame::to_string(self : StatsdistnegbinomialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_table_make(size : Int) -> StatsdistnegbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialTable::len(self : StatsdistnegbinomialTable) -> Int { self.size }

pub fn StatsdistnegbinomialTable::get(self : StatsdistnegbinomialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialTable::set(self : StatsdistnegbinomialTable, i : Int, v : Double) -> StatsdistnegbinomialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialTable::sum(self : StatsdistnegbinomialTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialTable::mean(self : StatsdistnegbinomialTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialTable::scale(self : StatsdistnegbinomialTable, f : Double) -> StatsdistnegbinomialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialTable::add(self : StatsdistnegbinomialTable, other : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialTable::copy(self : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialTable::fill(self : StatsdistnegbinomialTable, v : Double) -> StatsdistnegbinomialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialTable::min(self : StatsdistnegbinomialTable) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialTable::max(self : StatsdistnegbinomialTable) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialTable::to_string(self : StatsdistnegbinomialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_graphn_make(size : Int) -> StatsdistnegbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialGraphN::len(self : StatsdistnegbinomialGraphN) -> Int { self.size }

pub fn StatsdistnegbinomialGraphN::get(self : StatsdistnegbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialGraphN::set(self : StatsdistnegbinomialGraphN, i : Int, v : Double) -> StatsdistnegbinomialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialGraphN::sum(self : StatsdistnegbinomialGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialGraphN::mean(self : StatsdistnegbinomialGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialGraphN::scale(self : StatsdistnegbinomialGraphN, f : Double) -> StatsdistnegbinomialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialGraphN::add(self : StatsdistnegbinomialGraphN, other : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialGraphN::copy(self : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialGraphN::fill(self : StatsdistnegbinomialGraphN, v : Double) -> StatsdistnegbinomialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialGraphN::min(self : StatsdistnegbinomialGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialGraphN::max(self : StatsdistnegbinomialGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialGraphN::to_string(self : StatsdistnegbinomialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_node_make(size : Int) -> StatsdistnegbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialNode::len(self : StatsdistnegbinomialNode) -> Int { self.size }

pub fn StatsdistnegbinomialNode::get(self : StatsdistnegbinomialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialNode::set(self : StatsdistnegbinomialNode, i : Int, v : Double) -> StatsdistnegbinomialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialNode::sum(self : StatsdistnegbinomialNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialNode::mean(self : StatsdistnegbinomialNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialNode::scale(self : StatsdistnegbinomialNode, f : Double) -> StatsdistnegbinomialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialNode::add(self : StatsdistnegbinomialNode, other : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialNode::copy(self : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialNode::fill(self : StatsdistnegbinomialNode, v : Double) -> StatsdistnegbinomialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialNode::min(self : StatsdistnegbinomialNode) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialNode::max(self : StatsdistnegbinomialNode) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialNode::to_string(self : StatsdistnegbinomialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_edge_make(size : Int) -> StatsdistnegbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialEdge::len(self : StatsdistnegbinomialEdge) -> Int { self.size }

pub fn StatsdistnegbinomialEdge::get(self : StatsdistnegbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialEdge::set(self : StatsdistnegbinomialEdge, i : Int, v : Double) -> StatsdistnegbinomialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialEdge::sum(self : StatsdistnegbinomialEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialEdge::mean(self : StatsdistnegbinomialEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialEdge::scale(self : StatsdistnegbinomialEdge, f : Double) -> StatsdistnegbinomialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialEdge::add(self : StatsdistnegbinomialEdge, other : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialEdge::copy(self : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialEdge::fill(self : StatsdistnegbinomialEdge, v : Double) -> StatsdistnegbinomialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialEdge::min(self : StatsdistnegbinomialEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialEdge::max(self : StatsdistnegbinomialEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialEdge::to_string(self : StatsdistnegbinomialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_path_make(size : Int) -> StatsdistnegbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialPath::len(self : StatsdistnegbinomialPath) -> Int { self.size }

pub fn StatsdistnegbinomialPath::get(self : StatsdistnegbinomialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialPath::set(self : StatsdistnegbinomialPath, i : Int, v : Double) -> StatsdistnegbinomialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialPath::sum(self : StatsdistnegbinomialPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialPath::mean(self : StatsdistnegbinomialPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialPath::scale(self : StatsdistnegbinomialPath, f : Double) -> StatsdistnegbinomialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialPath::add(self : StatsdistnegbinomialPath, other : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialPath::copy(self : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialPath::fill(self : StatsdistnegbinomialPath, v : Double) -> StatsdistnegbinomialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialPath::min(self : StatsdistnegbinomialPath) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialPath::max(self : StatsdistnegbinomialPath) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialPath::to_string(self : StatsdistnegbinomialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cluster_make(size : Int) -> StatsdistnegbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialCluster::len(self : StatsdistnegbinomialCluster) -> Int { self.size }

pub fn StatsdistnegbinomialCluster::get(self : StatsdistnegbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialCluster::set(self : StatsdistnegbinomialCluster, i : Int, v : Double) -> StatsdistnegbinomialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCluster::sum(self : StatsdistnegbinomialCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialCluster::mean(self : StatsdistnegbinomialCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialCluster::scale(self : StatsdistnegbinomialCluster, f : Double) -> StatsdistnegbinomialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCluster::add(self : StatsdistnegbinomialCluster, other : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialCluster::copy(self : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCluster::fill(self : StatsdistnegbinomialCluster, v : Double) -> StatsdistnegbinomialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCluster::min(self : StatsdistnegbinomialCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialCluster::max(self : StatsdistnegbinomialCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialCluster::to_string(self : StatsdistnegbinomialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_model_make(size : Int) -> StatsdistnegbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialModel::len(self : StatsdistnegbinomialModel) -> Int { self.size }

pub fn StatsdistnegbinomialModel::get(self : StatsdistnegbinomialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialModel::set(self : StatsdistnegbinomialModel, i : Int, v : Double) -> StatsdistnegbinomialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialModel::sum(self : StatsdistnegbinomialModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialModel::mean(self : StatsdistnegbinomialModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialModel::scale(self : StatsdistnegbinomialModel, f : Double) -> StatsdistnegbinomialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialModel::add(self : StatsdistnegbinomialModel, other : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialModel::copy(self : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialModel::fill(self : StatsdistnegbinomialModel, v : Double) -> StatsdistnegbinomialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialModel::min(self : StatsdistnegbinomialModel) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialModel::max(self : StatsdistnegbinomialModel) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialModel::to_string(self : StatsdistnegbinomialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_layer_make(size : Int) -> StatsdistnegbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialLayer::len(self : StatsdistnegbinomialLayer) -> Int { self.size }

pub fn StatsdistnegbinomialLayer::get(self : StatsdistnegbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialLayer::set(self : StatsdistnegbinomialLayer, i : Int, v : Double) -> StatsdistnegbinomialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialLayer::sum(self : StatsdistnegbinomialLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialLayer::mean(self : StatsdistnegbinomialLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialLayer::scale(self : StatsdistnegbinomialLayer, f : Double) -> StatsdistnegbinomialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialLayer::add(self : StatsdistnegbinomialLayer, other : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialLayer::copy(self : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialLayer::fill(self : StatsdistnegbinomialLayer, v : Double) -> StatsdistnegbinomialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialLayer::min(self : StatsdistnegbinomialLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialLayer::max(self : StatsdistnegbinomialLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialLayer::to_string(self : StatsdistnegbinomialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_buffer_make(size : Int) -> StatsdistnegbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialBuffer::len(self : StatsdistnegbinomialBuffer) -> Int { self.size }

pub fn StatsdistnegbinomialBuffer::get(self : StatsdistnegbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialBuffer::set(self : StatsdistnegbinomialBuffer, i : Int, v : Double) -> StatsdistnegbinomialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialBuffer::sum(self : StatsdistnegbinomialBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialBuffer::mean(self : StatsdistnegbinomialBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialBuffer::scale(self : StatsdistnegbinomialBuffer, f : Double) -> StatsdistnegbinomialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialBuffer::add(self : StatsdistnegbinomialBuffer, other : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialBuffer::copy(self : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialBuffer::fill(self : StatsdistnegbinomialBuffer, v : Double) -> StatsdistnegbinomialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialBuffer::min(self : StatsdistnegbinomialBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialBuffer::max(self : StatsdistnegbinomialBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialBuffer::to_string(self : StatsdistnegbinomialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cursor_make(size : Int) -> StatsdistnegbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialCursor::len(self : StatsdistnegbinomialCursor) -> Int { self.size }

pub fn StatsdistnegbinomialCursor::get(self : StatsdistnegbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialCursor::set(self : StatsdistnegbinomialCursor, i : Int, v : Double) -> StatsdistnegbinomialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCursor::sum(self : StatsdistnegbinomialCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialCursor::mean(self : StatsdistnegbinomialCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialCursor::scale(self : StatsdistnegbinomialCursor, f : Double) -> StatsdistnegbinomialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCursor::add(self : StatsdistnegbinomialCursor, other : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialCursor::copy(self : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCursor::fill(self : StatsdistnegbinomialCursor, v : Double) -> StatsdistnegbinomialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialCursor::min(self : StatsdistnegbinomialCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialCursor::max(self : StatsdistnegbinomialCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialCursor::to_string(self : StatsdistnegbinomialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_view_make(size : Int) -> StatsdistnegbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialView::len(self : StatsdistnegbinomialView) -> Int { self.size }

pub fn StatsdistnegbinomialView::get(self : StatsdistnegbinomialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialView::set(self : StatsdistnegbinomialView, i : Int, v : Double) -> StatsdistnegbinomialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialView::sum(self : StatsdistnegbinomialView) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialView::mean(self : StatsdistnegbinomialView) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialView::scale(self : StatsdistnegbinomialView, f : Double) -> StatsdistnegbinomialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialView::add(self : StatsdistnegbinomialView, other : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialView::copy(self : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialView::fill(self : StatsdistnegbinomialView, v : Double) -> StatsdistnegbinomialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialView::min(self : StatsdistnegbinomialView) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialView::max(self : StatsdistnegbinomialView) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialView::to_string(self : StatsdistnegbinomialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_range_make(size : Int) -> StatsdistnegbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialRange::len(self : StatsdistnegbinomialRange) -> Int { self.size }

pub fn StatsdistnegbinomialRange::get(self : StatsdistnegbinomialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialRange::set(self : StatsdistnegbinomialRange, i : Int, v : Double) -> StatsdistnegbinomialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialRange::sum(self : StatsdistnegbinomialRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialRange::mean(self : StatsdistnegbinomialRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialRange::scale(self : StatsdistnegbinomialRange, f : Double) -> StatsdistnegbinomialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialRange::add(self : StatsdistnegbinomialRange, other : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialRange::copy(self : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialRange::fill(self : StatsdistnegbinomialRange, v : Double) -> StatsdistnegbinomialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialRange::min(self : StatsdistnegbinomialRange) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialRange::max(self : StatsdistnegbinomialRange) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialRange::to_string(self : StatsdistnegbinomialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_slice_make(size : Int) -> StatsdistnegbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnegbinomialSlice::len(self : StatsdistnegbinomialSlice) -> Int { self.size }

pub fn StatsdistnegbinomialSlice::get(self : StatsdistnegbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnegbinomialSlice::set(self : StatsdistnegbinomialSlice, i : Int, v : Double) -> StatsdistnegbinomialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialSlice::sum(self : StatsdistnegbinomialSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistnegbinomialSlice::mean(self : StatsdistnegbinomialSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistnegbinomialSlice::scale(self : StatsdistnegbinomialSlice, f : Double) -> StatsdistnegbinomialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialSlice::add(self : StatsdistnegbinomialSlice, other : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnegbinomialSlice::copy(self : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialSlice::fill(self : StatsdistnegbinomialSlice, v : Double) -> StatsdistnegbinomialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnegbinomialSlice::min(self : StatsdistnegbinomialSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistnegbinomialSlice::max(self : StatsdistnegbinomialSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistnegbinomialSlice::to_string(self : StatsdistnegbinomialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

