///===
/// extcore/stats_desc_bivariate

pub(all) struct StatsdescbivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_bivariate_make_point(x : Double, y : Double) -> StatsdescbivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_bivariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescbivariatePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescbivariatePoint::x(self : StatsdescbivariatePoint) -> Double { self.x }

pub fn StatsdescbivariatePoint::y(self : StatsdescbivariatePoint) -> Double { self.y }

pub fn StatsdescbivariatePoint::z(self : StatsdescbivariatePoint) -> Double { self.z }

pub fn StatsdescbivariatePoint::label(self : StatsdescbivariatePoint) -> Int { self.label }

pub fn StatsdescbivariatePoint::dist(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescbivariatePoint::add(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescbivariatePoint::sub(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescbivariatePoint::scale(self : StatsdescbivariatePoint, s : Double) -> StatsdescbivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescbivariatePoint::dot(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescbivariatePoint::cross(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescbivariatePoint::norm(self : StatsdescbivariatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescbivariatePoint::normalize(self : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescbivariatePoint::negate(self : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescbivariatePoint::mid(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescbivariatePoint::lerp(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint, t : Double) -> StatsdescbivariatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescbivariatePoint::to_string(self : StatsdescbivariatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescbivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_bivariate_make_series(vals : Array[Double], name : String) -> StatsdescbivariateSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescbivariateSeries::len(self : StatsdescbivariateSeries) -> Int { self.vals.length() }

pub fn StatsdescbivariateSeries::sum(self : StatsdescbivariateSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescbivariateSeries::mean(self : StatsdescbivariateSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescbivariateSeries::min(self : StatsdescbivariateSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescbivariateSeries::max(self : StatsdescbivariateSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescbivariateSeries::range(self : StatsdescbivariateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescbivariateSeries::variance(self : StatsdescbivariateSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescbivariateSeries::std(self : StatsdescbivariateSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescbivariateSeries::median(self : StatsdescbivariateSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescbivariateSeries::scale(self : StatsdescbivariateSeries, f : Double) -> StatsdescbivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::add(self : StatsdescbivariateSeries, other : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::sub(self : StatsdescbivariateSeries, other : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::normalize(self : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescbivariateSeries::cumsum(self : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescbivariateSeries::to_string(self : StatsdescbivariateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescbivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_bivariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescbivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_bivariate_matrix_identity(n : Int) -> StatsdescbivariateMatrix {
  let m = stats_desc_bivariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescbivariateMatrix::get(self : StatsdescbivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescbivariateMatrix::transpose(self : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescbivariateMatrix::add(self : StatsdescbivariateMatrix, other : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_bivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescbivariateMatrix::scale(self : StatsdescbivariateMatrix, s : Double) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescbivariateMatrix::multiply(self : StatsdescbivariateMatrix, other : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if self.cols != other.rows { return stats_desc_bivariate_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_bivariate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdescbivariateMatrix::trace(self : StatsdescbivariateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescbivariateMatrix::det(self : StatsdescbivariateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescbivariateMatrix::norm(self : StatsdescbivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescbivariateMatrix::to_string(self : StatsdescbivariateMatrix) -> String {
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

pub(all) struct StatsdescbivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_bivariate_make_vector(comps : Array[Double]) -> StatsdescbivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_bivariate_vector_zero(dim : Int) -> StatsdescbivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescbivariateVector::add(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescbivariateVector::sub(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescbivariateVector::scale(self : StatsdescbivariateVector, s : Double) -> StatsdescbivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescbivariateVector::dot(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescbivariateVector::norm(self : StatsdescbivariateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescbivariateVector::normalize(self : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescbivariateVector::dist(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescbivariateVector::to_string(self : StatsdescbivariateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescbivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_frame_make(size : Int) -> StatsdescbivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateFrame::len(self : StatsdescbivariateFrame) -> Int { self.size }

pub fn StatsdescbivariateFrame::get(self : StatsdescbivariateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateFrame::set(self : StatsdescbivariateFrame, i : Int, v : Double) -> StatsdescbivariateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateFrame::sum(self : StatsdescbivariateFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateFrame::mean(self : StatsdescbivariateFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateFrame::scale(self : StatsdescbivariateFrame, f : Double) -> StatsdescbivariateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateFrame::add(self : StatsdescbivariateFrame, other : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateFrame::copy(self : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateFrame::fill(self : StatsdescbivariateFrame, v : Double) -> StatsdescbivariateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateFrame::min(self : StatsdescbivariateFrame) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateFrame::max(self : StatsdescbivariateFrame) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateFrame::to_string(self : StatsdescbivariateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_table_make(size : Int) -> StatsdescbivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateTable::len(self : StatsdescbivariateTable) -> Int { self.size }

pub fn StatsdescbivariateTable::get(self : StatsdescbivariateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateTable::set(self : StatsdescbivariateTable, i : Int, v : Double) -> StatsdescbivariateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateTable::sum(self : StatsdescbivariateTable) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateTable::mean(self : StatsdescbivariateTable) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateTable::scale(self : StatsdescbivariateTable, f : Double) -> StatsdescbivariateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateTable::add(self : StatsdescbivariateTable, other : StatsdescbivariateTable) -> StatsdescbivariateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateTable::copy(self : StatsdescbivariateTable) -> StatsdescbivariateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateTable::fill(self : StatsdescbivariateTable, v : Double) -> StatsdescbivariateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateTable::min(self : StatsdescbivariateTable) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateTable::max(self : StatsdescbivariateTable) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateTable::to_string(self : StatsdescbivariateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_graphn_make(size : Int) -> StatsdescbivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateGraphN::len(self : StatsdescbivariateGraphN) -> Int { self.size }

pub fn StatsdescbivariateGraphN::get(self : StatsdescbivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateGraphN::set(self : StatsdescbivariateGraphN, i : Int, v : Double) -> StatsdescbivariateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateGraphN::sum(self : StatsdescbivariateGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateGraphN::mean(self : StatsdescbivariateGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateGraphN::scale(self : StatsdescbivariateGraphN, f : Double) -> StatsdescbivariateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateGraphN::add(self : StatsdescbivariateGraphN, other : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateGraphN::copy(self : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateGraphN::fill(self : StatsdescbivariateGraphN, v : Double) -> StatsdescbivariateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateGraphN::min(self : StatsdescbivariateGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateGraphN::max(self : StatsdescbivariateGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateGraphN::to_string(self : StatsdescbivariateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_node_make(size : Int) -> StatsdescbivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateNode::len(self : StatsdescbivariateNode) -> Int { self.size }

pub fn StatsdescbivariateNode::get(self : StatsdescbivariateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateNode::set(self : StatsdescbivariateNode, i : Int, v : Double) -> StatsdescbivariateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateNode::sum(self : StatsdescbivariateNode) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateNode::mean(self : StatsdescbivariateNode) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateNode::scale(self : StatsdescbivariateNode, f : Double) -> StatsdescbivariateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateNode::add(self : StatsdescbivariateNode, other : StatsdescbivariateNode) -> StatsdescbivariateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateNode::copy(self : StatsdescbivariateNode) -> StatsdescbivariateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateNode::fill(self : StatsdescbivariateNode, v : Double) -> StatsdescbivariateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateNode::min(self : StatsdescbivariateNode) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateNode::max(self : StatsdescbivariateNode) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateNode::to_string(self : StatsdescbivariateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_edge_make(size : Int) -> StatsdescbivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateEdge::len(self : StatsdescbivariateEdge) -> Int { self.size }

pub fn StatsdescbivariateEdge::get(self : StatsdescbivariateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateEdge::set(self : StatsdescbivariateEdge, i : Int, v : Double) -> StatsdescbivariateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateEdge::sum(self : StatsdescbivariateEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateEdge::mean(self : StatsdescbivariateEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateEdge::scale(self : StatsdescbivariateEdge, f : Double) -> StatsdescbivariateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateEdge::add(self : StatsdescbivariateEdge, other : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateEdge::copy(self : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateEdge::fill(self : StatsdescbivariateEdge, v : Double) -> StatsdescbivariateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateEdge::min(self : StatsdescbivariateEdge) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateEdge::max(self : StatsdescbivariateEdge) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateEdge::to_string(self : StatsdescbivariateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_path_make(size : Int) -> StatsdescbivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariatePath::len(self : StatsdescbivariatePath) -> Int { self.size }

pub fn StatsdescbivariatePath::get(self : StatsdescbivariatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariatePath::set(self : StatsdescbivariatePath, i : Int, v : Double) -> StatsdescbivariatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariatePath::sum(self : StatsdescbivariatePath) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariatePath::mean(self : StatsdescbivariatePath) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariatePath::scale(self : StatsdescbivariatePath, f : Double) -> StatsdescbivariatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariatePath::add(self : StatsdescbivariatePath, other : StatsdescbivariatePath) -> StatsdescbivariatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariatePath::copy(self : StatsdescbivariatePath) -> StatsdescbivariatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariatePath::fill(self : StatsdescbivariatePath, v : Double) -> StatsdescbivariatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariatePath::min(self : StatsdescbivariatePath) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariatePath::max(self : StatsdescbivariatePath) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariatePath::to_string(self : StatsdescbivariatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cluster_make(size : Int) -> StatsdescbivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateCluster::len(self : StatsdescbivariateCluster) -> Int { self.size }

pub fn StatsdescbivariateCluster::get(self : StatsdescbivariateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateCluster::set(self : StatsdescbivariateCluster, i : Int, v : Double) -> StatsdescbivariateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCluster::sum(self : StatsdescbivariateCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateCluster::mean(self : StatsdescbivariateCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateCluster::scale(self : StatsdescbivariateCluster, f : Double) -> StatsdescbivariateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCluster::add(self : StatsdescbivariateCluster, other : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateCluster::copy(self : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCluster::fill(self : StatsdescbivariateCluster, v : Double) -> StatsdescbivariateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCluster::min(self : StatsdescbivariateCluster) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateCluster::max(self : StatsdescbivariateCluster) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateCluster::to_string(self : StatsdescbivariateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_model_make(size : Int) -> StatsdescbivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateModel::len(self : StatsdescbivariateModel) -> Int { self.size }

pub fn StatsdescbivariateModel::get(self : StatsdescbivariateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateModel::set(self : StatsdescbivariateModel, i : Int, v : Double) -> StatsdescbivariateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateModel::sum(self : StatsdescbivariateModel) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateModel::mean(self : StatsdescbivariateModel) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateModel::scale(self : StatsdescbivariateModel, f : Double) -> StatsdescbivariateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateModel::add(self : StatsdescbivariateModel, other : StatsdescbivariateModel) -> StatsdescbivariateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateModel::copy(self : StatsdescbivariateModel) -> StatsdescbivariateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateModel::fill(self : StatsdescbivariateModel, v : Double) -> StatsdescbivariateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateModel::min(self : StatsdescbivariateModel) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateModel::max(self : StatsdescbivariateModel) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateModel::to_string(self : StatsdescbivariateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_layer_make(size : Int) -> StatsdescbivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateLayer::len(self : StatsdescbivariateLayer) -> Int { self.size }

pub fn StatsdescbivariateLayer::get(self : StatsdescbivariateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateLayer::set(self : StatsdescbivariateLayer, i : Int, v : Double) -> StatsdescbivariateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateLayer::sum(self : StatsdescbivariateLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateLayer::mean(self : StatsdescbivariateLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateLayer::scale(self : StatsdescbivariateLayer, f : Double) -> StatsdescbivariateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateLayer::add(self : StatsdescbivariateLayer, other : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateLayer::copy(self : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateLayer::fill(self : StatsdescbivariateLayer, v : Double) -> StatsdescbivariateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateLayer::min(self : StatsdescbivariateLayer) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateLayer::max(self : StatsdescbivariateLayer) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateLayer::to_string(self : StatsdescbivariateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_buffer_make(size : Int) -> StatsdescbivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateBuffer::len(self : StatsdescbivariateBuffer) -> Int { self.size }

pub fn StatsdescbivariateBuffer::get(self : StatsdescbivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateBuffer::set(self : StatsdescbivariateBuffer, i : Int, v : Double) -> StatsdescbivariateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateBuffer::sum(self : StatsdescbivariateBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateBuffer::mean(self : StatsdescbivariateBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateBuffer::scale(self : StatsdescbivariateBuffer, f : Double) -> StatsdescbivariateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateBuffer::add(self : StatsdescbivariateBuffer, other : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateBuffer::copy(self : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateBuffer::fill(self : StatsdescbivariateBuffer, v : Double) -> StatsdescbivariateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateBuffer::min(self : StatsdescbivariateBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateBuffer::max(self : StatsdescbivariateBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateBuffer::to_string(self : StatsdescbivariateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cursor_make(size : Int) -> StatsdescbivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateCursor::len(self : StatsdescbivariateCursor) -> Int { self.size }

pub fn StatsdescbivariateCursor::get(self : StatsdescbivariateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateCursor::set(self : StatsdescbivariateCursor, i : Int, v : Double) -> StatsdescbivariateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCursor::sum(self : StatsdescbivariateCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateCursor::mean(self : StatsdescbivariateCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateCursor::scale(self : StatsdescbivariateCursor, f : Double) -> StatsdescbivariateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCursor::add(self : StatsdescbivariateCursor, other : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateCursor::copy(self : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCursor::fill(self : StatsdescbivariateCursor, v : Double) -> StatsdescbivariateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateCursor::min(self : StatsdescbivariateCursor) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateCursor::max(self : StatsdescbivariateCursor) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateCursor::to_string(self : StatsdescbivariateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_view_make(size : Int) -> StatsdescbivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateView::len(self : StatsdescbivariateView) -> Int { self.size }

pub fn StatsdescbivariateView::get(self : StatsdescbivariateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateView::set(self : StatsdescbivariateView, i : Int, v : Double) -> StatsdescbivariateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateView::sum(self : StatsdescbivariateView) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateView::mean(self : StatsdescbivariateView) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateView::scale(self : StatsdescbivariateView, f : Double) -> StatsdescbivariateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateView::add(self : StatsdescbivariateView, other : StatsdescbivariateView) -> StatsdescbivariateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateView::copy(self : StatsdescbivariateView) -> StatsdescbivariateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateView::fill(self : StatsdescbivariateView, v : Double) -> StatsdescbivariateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateView::min(self : StatsdescbivariateView) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateView::max(self : StatsdescbivariateView) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateView::to_string(self : StatsdescbivariateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_range_make(size : Int) -> StatsdescbivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateRange::len(self : StatsdescbivariateRange) -> Int { self.size }

pub fn StatsdescbivariateRange::get(self : StatsdescbivariateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateRange::set(self : StatsdescbivariateRange, i : Int, v : Double) -> StatsdescbivariateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateRange::sum(self : StatsdescbivariateRange) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateRange::mean(self : StatsdescbivariateRange) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateRange::scale(self : StatsdescbivariateRange, f : Double) -> StatsdescbivariateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateRange::add(self : StatsdescbivariateRange, other : StatsdescbivariateRange) -> StatsdescbivariateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateRange::copy(self : StatsdescbivariateRange) -> StatsdescbivariateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateRange::fill(self : StatsdescbivariateRange, v : Double) -> StatsdescbivariateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateRange::min(self : StatsdescbivariateRange) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateRange::max(self : StatsdescbivariateRange) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateRange::to_string(self : StatsdescbivariateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_slice_make(size : Int) -> StatsdescbivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescbivariateSlice::len(self : StatsdescbivariateSlice) -> Int { self.size }

pub fn StatsdescbivariateSlice::get(self : StatsdescbivariateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescbivariateSlice::set(self : StatsdescbivariateSlice, i : Int, v : Double) -> StatsdescbivariateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateSlice::sum(self : StatsdescbivariateSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdescbivariateSlice::mean(self : StatsdescbivariateSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdescbivariateSlice::scale(self : StatsdescbivariateSlice, f : Double) -> StatsdescbivariateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateSlice::add(self : StatsdescbivariateSlice, other : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescbivariateSlice::copy(self : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateSlice::fill(self : StatsdescbivariateSlice, v : Double) -> StatsdescbivariateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescbivariateSlice::min(self : StatsdescbivariateSlice) -> Double { @_common.min(self.data) }

pub fn StatsdescbivariateSlice::max(self : StatsdescbivariateSlice) -> Double { @_common.max(self.data) }

pub fn StatsdescbivariateSlice::to_string(self : StatsdescbivariateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

