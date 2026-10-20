///===
/// extcore/stats_test_goodness

pub(all) struct StatstestgoodnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_goodness_make_point(x : Double, y : Double) -> StatstestgoodnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_goodness_make_point3(x : Double, y : Double, z : Double) -> StatstestgoodnessPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestgoodnessPoint::x(self : StatstestgoodnessPoint) -> Double { self.x }

pub fn StatstestgoodnessPoint::y(self : StatstestgoodnessPoint) -> Double { self.y }

pub fn StatstestgoodnessPoint::z(self : StatstestgoodnessPoint) -> Double { self.z }

pub fn StatstestgoodnessPoint::label(self : StatstestgoodnessPoint) -> Int { self.label }

pub fn StatstestgoodnessPoint::dist(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestgoodnessPoint::add(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestgoodnessPoint::sub(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestgoodnessPoint::scale(self : StatstestgoodnessPoint, s : Double) -> StatstestgoodnessPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestgoodnessPoint::dot(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestgoodnessPoint::cross(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestgoodnessPoint::norm(self : StatstestgoodnessPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestgoodnessPoint::normalize(self : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestgoodnessPoint::negate(self : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestgoodnessPoint::mid(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestgoodnessPoint::lerp(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint, t : Double) -> StatstestgoodnessPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestgoodnessPoint::to_string(self : StatstestgoodnessPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestgoodnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_goodness_make_series(vals : Array[Double], name : String) -> StatstestgoodnessSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestgoodnessSeries::len(self : StatstestgoodnessSeries) -> Int { self.vals.length() }

pub fn StatstestgoodnessSeries::sum(self : StatstestgoodnessSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestgoodnessSeries::mean(self : StatstestgoodnessSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestgoodnessSeries::min(self : StatstestgoodnessSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestgoodnessSeries::max(self : StatstestgoodnessSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestgoodnessSeries::range(self : StatstestgoodnessSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestgoodnessSeries::variance(self : StatstestgoodnessSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestgoodnessSeries::std(self : StatstestgoodnessSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestgoodnessSeries::median(self : StatstestgoodnessSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestgoodnessSeries::scale(self : StatstestgoodnessSeries, f : Double) -> StatstestgoodnessSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::add(self : StatstestgoodnessSeries, other : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::sub(self : StatstestgoodnessSeries, other : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::normalize(self : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestgoodnessSeries::cumsum(self : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestgoodnessSeries::to_string(self : StatstestgoodnessSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestgoodnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_goodness_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestgoodnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_goodness_matrix_identity(n : Int) -> StatstestgoodnessMatrix {
  let m = stats_test_goodness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestgoodnessMatrix::get(self : StatstestgoodnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestgoodnessMatrix::transpose(self : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestgoodnessMatrix::add(self : StatstestgoodnessMatrix, other : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_goodness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestgoodnessMatrix::scale(self : StatstestgoodnessMatrix, s : Double) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestgoodnessMatrix::multiply(self : StatstestgoodnessMatrix, other : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if self.cols != other.rows { return stats_test_goodness_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_goodness_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstestgoodnessMatrix::trace(self : StatstestgoodnessMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestgoodnessMatrix::det(self : StatstestgoodnessMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestgoodnessMatrix::norm(self : StatstestgoodnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestgoodnessMatrix::to_string(self : StatstestgoodnessMatrix) -> String {
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

pub(all) struct StatstestgoodnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_goodness_make_vector(comps : Array[Double]) -> StatstestgoodnessVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_goodness_vector_zero(dim : Int) -> StatstestgoodnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestgoodnessVector::add(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestgoodnessVector::sub(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestgoodnessVector::scale(self : StatstestgoodnessVector, s : Double) -> StatstestgoodnessVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestgoodnessVector::dot(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestgoodnessVector::norm(self : StatstestgoodnessVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestgoodnessVector::normalize(self : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestgoodnessVector::dist(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestgoodnessVector::to_string(self : StatstestgoodnessVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestgoodnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_frame_make(size : Int) -> StatstestgoodnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessFrame::len(self : StatstestgoodnessFrame) -> Int { self.size }

pub fn StatstestgoodnessFrame::get(self : StatstestgoodnessFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessFrame::set(self : StatstestgoodnessFrame, i : Int, v : Double) -> StatstestgoodnessFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessFrame::sum(self : StatstestgoodnessFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessFrame::mean(self : StatstestgoodnessFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessFrame::scale(self : StatstestgoodnessFrame, f : Double) -> StatstestgoodnessFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessFrame::add(self : StatstestgoodnessFrame, other : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessFrame::copy(self : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessFrame::fill(self : StatstestgoodnessFrame, v : Double) -> StatstestgoodnessFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessFrame::min(self : StatstestgoodnessFrame) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessFrame::max(self : StatstestgoodnessFrame) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessFrame::to_string(self : StatstestgoodnessFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_table_make(size : Int) -> StatstestgoodnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessTable::len(self : StatstestgoodnessTable) -> Int { self.size }

pub fn StatstestgoodnessTable::get(self : StatstestgoodnessTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessTable::set(self : StatstestgoodnessTable, i : Int, v : Double) -> StatstestgoodnessTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessTable::sum(self : StatstestgoodnessTable) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessTable::mean(self : StatstestgoodnessTable) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessTable::scale(self : StatstestgoodnessTable, f : Double) -> StatstestgoodnessTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessTable::add(self : StatstestgoodnessTable, other : StatstestgoodnessTable) -> StatstestgoodnessTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessTable::copy(self : StatstestgoodnessTable) -> StatstestgoodnessTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessTable::fill(self : StatstestgoodnessTable, v : Double) -> StatstestgoodnessTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessTable::min(self : StatstestgoodnessTable) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessTable::max(self : StatstestgoodnessTable) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessTable::to_string(self : StatstestgoodnessTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_graphn_make(size : Int) -> StatstestgoodnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessGraphN::len(self : StatstestgoodnessGraphN) -> Int { self.size }

pub fn StatstestgoodnessGraphN::get(self : StatstestgoodnessGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessGraphN::set(self : StatstestgoodnessGraphN, i : Int, v : Double) -> StatstestgoodnessGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessGraphN::sum(self : StatstestgoodnessGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessGraphN::mean(self : StatstestgoodnessGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessGraphN::scale(self : StatstestgoodnessGraphN, f : Double) -> StatstestgoodnessGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessGraphN::add(self : StatstestgoodnessGraphN, other : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessGraphN::copy(self : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessGraphN::fill(self : StatstestgoodnessGraphN, v : Double) -> StatstestgoodnessGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessGraphN::min(self : StatstestgoodnessGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessGraphN::max(self : StatstestgoodnessGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessGraphN::to_string(self : StatstestgoodnessGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_node_make(size : Int) -> StatstestgoodnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessNode::len(self : StatstestgoodnessNode) -> Int { self.size }

pub fn StatstestgoodnessNode::get(self : StatstestgoodnessNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessNode::set(self : StatstestgoodnessNode, i : Int, v : Double) -> StatstestgoodnessNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessNode::sum(self : StatstestgoodnessNode) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessNode::mean(self : StatstestgoodnessNode) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessNode::scale(self : StatstestgoodnessNode, f : Double) -> StatstestgoodnessNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessNode::add(self : StatstestgoodnessNode, other : StatstestgoodnessNode) -> StatstestgoodnessNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessNode::copy(self : StatstestgoodnessNode) -> StatstestgoodnessNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessNode::fill(self : StatstestgoodnessNode, v : Double) -> StatstestgoodnessNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessNode::min(self : StatstestgoodnessNode) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessNode::max(self : StatstestgoodnessNode) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessNode::to_string(self : StatstestgoodnessNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_edge_make(size : Int) -> StatstestgoodnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessEdge::len(self : StatstestgoodnessEdge) -> Int { self.size }

pub fn StatstestgoodnessEdge::get(self : StatstestgoodnessEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessEdge::set(self : StatstestgoodnessEdge, i : Int, v : Double) -> StatstestgoodnessEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessEdge::sum(self : StatstestgoodnessEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessEdge::mean(self : StatstestgoodnessEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessEdge::scale(self : StatstestgoodnessEdge, f : Double) -> StatstestgoodnessEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessEdge::add(self : StatstestgoodnessEdge, other : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessEdge::copy(self : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessEdge::fill(self : StatstestgoodnessEdge, v : Double) -> StatstestgoodnessEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessEdge::min(self : StatstestgoodnessEdge) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessEdge::max(self : StatstestgoodnessEdge) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessEdge::to_string(self : StatstestgoodnessEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_path_make(size : Int) -> StatstestgoodnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessPath::len(self : StatstestgoodnessPath) -> Int { self.size }

pub fn StatstestgoodnessPath::get(self : StatstestgoodnessPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessPath::set(self : StatstestgoodnessPath, i : Int, v : Double) -> StatstestgoodnessPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessPath::sum(self : StatstestgoodnessPath) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessPath::mean(self : StatstestgoodnessPath) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessPath::scale(self : StatstestgoodnessPath, f : Double) -> StatstestgoodnessPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessPath::add(self : StatstestgoodnessPath, other : StatstestgoodnessPath) -> StatstestgoodnessPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessPath::copy(self : StatstestgoodnessPath) -> StatstestgoodnessPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessPath::fill(self : StatstestgoodnessPath, v : Double) -> StatstestgoodnessPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessPath::min(self : StatstestgoodnessPath) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessPath::max(self : StatstestgoodnessPath) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessPath::to_string(self : StatstestgoodnessPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cluster_make(size : Int) -> StatstestgoodnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessCluster::len(self : StatstestgoodnessCluster) -> Int { self.size }

pub fn StatstestgoodnessCluster::get(self : StatstestgoodnessCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessCluster::set(self : StatstestgoodnessCluster, i : Int, v : Double) -> StatstestgoodnessCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCluster::sum(self : StatstestgoodnessCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessCluster::mean(self : StatstestgoodnessCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessCluster::scale(self : StatstestgoodnessCluster, f : Double) -> StatstestgoodnessCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCluster::add(self : StatstestgoodnessCluster, other : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessCluster::copy(self : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCluster::fill(self : StatstestgoodnessCluster, v : Double) -> StatstestgoodnessCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCluster::min(self : StatstestgoodnessCluster) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessCluster::max(self : StatstestgoodnessCluster) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessCluster::to_string(self : StatstestgoodnessCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_model_make(size : Int) -> StatstestgoodnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessModel::len(self : StatstestgoodnessModel) -> Int { self.size }

pub fn StatstestgoodnessModel::get(self : StatstestgoodnessModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessModel::set(self : StatstestgoodnessModel, i : Int, v : Double) -> StatstestgoodnessModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessModel::sum(self : StatstestgoodnessModel) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessModel::mean(self : StatstestgoodnessModel) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessModel::scale(self : StatstestgoodnessModel, f : Double) -> StatstestgoodnessModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessModel::add(self : StatstestgoodnessModel, other : StatstestgoodnessModel) -> StatstestgoodnessModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessModel::copy(self : StatstestgoodnessModel) -> StatstestgoodnessModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessModel::fill(self : StatstestgoodnessModel, v : Double) -> StatstestgoodnessModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessModel::min(self : StatstestgoodnessModel) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessModel::max(self : StatstestgoodnessModel) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessModel::to_string(self : StatstestgoodnessModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_layer_make(size : Int) -> StatstestgoodnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessLayer::len(self : StatstestgoodnessLayer) -> Int { self.size }

pub fn StatstestgoodnessLayer::get(self : StatstestgoodnessLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessLayer::set(self : StatstestgoodnessLayer, i : Int, v : Double) -> StatstestgoodnessLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessLayer::sum(self : StatstestgoodnessLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessLayer::mean(self : StatstestgoodnessLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessLayer::scale(self : StatstestgoodnessLayer, f : Double) -> StatstestgoodnessLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessLayer::add(self : StatstestgoodnessLayer, other : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessLayer::copy(self : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessLayer::fill(self : StatstestgoodnessLayer, v : Double) -> StatstestgoodnessLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessLayer::min(self : StatstestgoodnessLayer) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessLayer::max(self : StatstestgoodnessLayer) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessLayer::to_string(self : StatstestgoodnessLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_buffer_make(size : Int) -> StatstestgoodnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessBuffer::len(self : StatstestgoodnessBuffer) -> Int { self.size }

pub fn StatstestgoodnessBuffer::get(self : StatstestgoodnessBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessBuffer::set(self : StatstestgoodnessBuffer, i : Int, v : Double) -> StatstestgoodnessBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessBuffer::sum(self : StatstestgoodnessBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessBuffer::mean(self : StatstestgoodnessBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessBuffer::scale(self : StatstestgoodnessBuffer, f : Double) -> StatstestgoodnessBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessBuffer::add(self : StatstestgoodnessBuffer, other : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessBuffer::copy(self : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessBuffer::fill(self : StatstestgoodnessBuffer, v : Double) -> StatstestgoodnessBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessBuffer::min(self : StatstestgoodnessBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessBuffer::max(self : StatstestgoodnessBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessBuffer::to_string(self : StatstestgoodnessBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cursor_make(size : Int) -> StatstestgoodnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessCursor::len(self : StatstestgoodnessCursor) -> Int { self.size }

pub fn StatstestgoodnessCursor::get(self : StatstestgoodnessCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessCursor::set(self : StatstestgoodnessCursor, i : Int, v : Double) -> StatstestgoodnessCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCursor::sum(self : StatstestgoodnessCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessCursor::mean(self : StatstestgoodnessCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessCursor::scale(self : StatstestgoodnessCursor, f : Double) -> StatstestgoodnessCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCursor::add(self : StatstestgoodnessCursor, other : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessCursor::copy(self : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCursor::fill(self : StatstestgoodnessCursor, v : Double) -> StatstestgoodnessCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessCursor::min(self : StatstestgoodnessCursor) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessCursor::max(self : StatstestgoodnessCursor) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessCursor::to_string(self : StatstestgoodnessCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_view_make(size : Int) -> StatstestgoodnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessView::len(self : StatstestgoodnessView) -> Int { self.size }

pub fn StatstestgoodnessView::get(self : StatstestgoodnessView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessView::set(self : StatstestgoodnessView, i : Int, v : Double) -> StatstestgoodnessView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessView::sum(self : StatstestgoodnessView) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessView::mean(self : StatstestgoodnessView) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessView::scale(self : StatstestgoodnessView, f : Double) -> StatstestgoodnessView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessView::add(self : StatstestgoodnessView, other : StatstestgoodnessView) -> StatstestgoodnessView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessView::copy(self : StatstestgoodnessView) -> StatstestgoodnessView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessView::fill(self : StatstestgoodnessView, v : Double) -> StatstestgoodnessView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessView::min(self : StatstestgoodnessView) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessView::max(self : StatstestgoodnessView) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessView::to_string(self : StatstestgoodnessView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_range_make(size : Int) -> StatstestgoodnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessRange::len(self : StatstestgoodnessRange) -> Int { self.size }

pub fn StatstestgoodnessRange::get(self : StatstestgoodnessRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessRange::set(self : StatstestgoodnessRange, i : Int, v : Double) -> StatstestgoodnessRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessRange::sum(self : StatstestgoodnessRange) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessRange::mean(self : StatstestgoodnessRange) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessRange::scale(self : StatstestgoodnessRange, f : Double) -> StatstestgoodnessRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessRange::add(self : StatstestgoodnessRange, other : StatstestgoodnessRange) -> StatstestgoodnessRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessRange::copy(self : StatstestgoodnessRange) -> StatstestgoodnessRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessRange::fill(self : StatstestgoodnessRange, v : Double) -> StatstestgoodnessRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessRange::min(self : StatstestgoodnessRange) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessRange::max(self : StatstestgoodnessRange) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessRange::to_string(self : StatstestgoodnessRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_slice_make(size : Int) -> StatstestgoodnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestgoodnessSlice::len(self : StatstestgoodnessSlice) -> Int { self.size }

pub fn StatstestgoodnessSlice::get(self : StatstestgoodnessSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestgoodnessSlice::set(self : StatstestgoodnessSlice, i : Int, v : Double) -> StatstestgoodnessSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessSlice::sum(self : StatstestgoodnessSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestgoodnessSlice::mean(self : StatstestgoodnessSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestgoodnessSlice::scale(self : StatstestgoodnessSlice, f : Double) -> StatstestgoodnessSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessSlice::add(self : StatstestgoodnessSlice, other : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestgoodnessSlice::copy(self : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessSlice::fill(self : StatstestgoodnessSlice, v : Double) -> StatstestgoodnessSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestgoodnessSlice::min(self : StatstestgoodnessSlice) -> Double { @_common.min(self.data) }

pub fn StatstestgoodnessSlice::max(self : StatstestgoodnessSlice) -> Double { @_common.max(self.data) }

pub fn StatstestgoodnessSlice::to_string(self : StatstestgoodnessSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

