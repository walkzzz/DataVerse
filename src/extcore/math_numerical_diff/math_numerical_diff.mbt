///===
/// extcore/math_numerical_diff

pub(all) struct MathnumericaldiffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_diff_make_point(x : Double, y : Double) -> MathnumericaldiffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_diff_make_point3(x : Double, y : Double, z : Double) -> MathnumericaldiffPoint {
  { x, y, z, label: 0 }
}

pub fn MathnumericaldiffPoint::x(self : MathnumericaldiffPoint) -> Double { self.x }

pub fn MathnumericaldiffPoint::y(self : MathnumericaldiffPoint) -> Double { self.y }

pub fn MathnumericaldiffPoint::z(self : MathnumericaldiffPoint) -> Double { self.z }

pub fn MathnumericaldiffPoint::label(self : MathnumericaldiffPoint) -> Int { self.label }

pub fn MathnumericaldiffPoint::dist(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnumericaldiffPoint::add(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnumericaldiffPoint::sub(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnumericaldiffPoint::scale(self : MathnumericaldiffPoint, s : Double) -> MathnumericaldiffPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnumericaldiffPoint::dot(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnumericaldiffPoint::cross(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnumericaldiffPoint::norm(self : MathnumericaldiffPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnumericaldiffPoint::normalize(self : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericaldiffPoint::negate(self : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnumericaldiffPoint::mid(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnumericaldiffPoint::lerp(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint, t : Double) -> MathnumericaldiffPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnumericaldiffPoint::to_string(self : MathnumericaldiffPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnumericaldiffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_diff_make_series(vals : Array[Double], name : String) -> MathnumericaldiffSeries {
  { vals, name, meta: 0 }
}

pub fn MathnumericaldiffSeries::len(self : MathnumericaldiffSeries) -> Int { self.vals.length() }

pub fn MathnumericaldiffSeries::sum(self : MathnumericaldiffSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnumericaldiffSeries::mean(self : MathnumericaldiffSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnumericaldiffSeries::min(self : MathnumericaldiffSeries) -> Double { @_common.min(self.vals) }

pub fn MathnumericaldiffSeries::max(self : MathnumericaldiffSeries) -> Double { @_common.max(self.vals) }

pub fn MathnumericaldiffSeries::range(self : MathnumericaldiffSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnumericaldiffSeries::variance(self : MathnumericaldiffSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnumericaldiffSeries::std(self : MathnumericaldiffSeries) -> Double { @_common.std(self.vals) }

pub fn MathnumericaldiffSeries::median(self : MathnumericaldiffSeries) -> Double { @_common.median(self.vals) }

pub fn MathnumericaldiffSeries::scale(self : MathnumericaldiffSeries, f : Double) -> MathnumericaldiffSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::add(self : MathnumericaldiffSeries, other : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::sub(self : MathnumericaldiffSeries, other : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::normalize(self : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnumericaldiffSeries::cumsum(self : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnumericaldiffSeries::to_string(self : MathnumericaldiffSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericaldiffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericaldiffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_numerical_diff_matrix_identity(n : Int) -> MathnumericaldiffMatrix {
  let m = math_numerical_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnumericaldiffMatrix::get(self : MathnumericaldiffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnumericaldiffMatrix::transpose(self : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnumericaldiffMatrix::add(self : MathnumericaldiffMatrix, other : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_numerical_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnumericaldiffMatrix::scale(self : MathnumericaldiffMatrix, s : Double) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnumericaldiffMatrix::multiply(self : MathnumericaldiffMatrix, other : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if self.cols != other.rows { return math_numerical_diff_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_numerical_diff_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathnumericaldiffMatrix::trace(self : MathnumericaldiffMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnumericaldiffMatrix::det(self : MathnumericaldiffMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnumericaldiffMatrix::norm(self : MathnumericaldiffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnumericaldiffMatrix::to_string(self : MathnumericaldiffMatrix) -> String {
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

pub(all) struct MathnumericaldiffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_diff_make_vector(comps : Array[Double]) -> MathnumericaldiffVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_diff_vector_zero(dim : Int) -> MathnumericaldiffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnumericaldiffVector::add(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericaldiffVector::sub(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericaldiffVector::scale(self : MathnumericaldiffVector, s : Double) -> MathnumericaldiffVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnumericaldiffVector::dot(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnumericaldiffVector::norm(self : MathnumericaldiffVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnumericaldiffVector::normalize(self : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericaldiffVector::dist(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnumericaldiffVector::to_string(self : MathnumericaldiffVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericaldiffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_frame_make(size : Int) -> MathnumericaldiffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffFrame::len(self : MathnumericaldiffFrame) -> Int { self.size }

pub fn MathnumericaldiffFrame::get(self : MathnumericaldiffFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffFrame::set(self : MathnumericaldiffFrame, i : Int, v : Double) -> MathnumericaldiffFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffFrame::sum(self : MathnumericaldiffFrame) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffFrame::mean(self : MathnumericaldiffFrame) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffFrame::scale(self : MathnumericaldiffFrame, f : Double) -> MathnumericaldiffFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffFrame::add(self : MathnumericaldiffFrame, other : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffFrame::copy(self : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffFrame::fill(self : MathnumericaldiffFrame, v : Double) -> MathnumericaldiffFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffFrame::min(self : MathnumericaldiffFrame) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffFrame::max(self : MathnumericaldiffFrame) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffFrame::to_string(self : MathnumericaldiffFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_table_make(size : Int) -> MathnumericaldiffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffTable::len(self : MathnumericaldiffTable) -> Int { self.size }

pub fn MathnumericaldiffTable::get(self : MathnumericaldiffTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffTable::set(self : MathnumericaldiffTable, i : Int, v : Double) -> MathnumericaldiffTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffTable::sum(self : MathnumericaldiffTable) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffTable::mean(self : MathnumericaldiffTable) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffTable::scale(self : MathnumericaldiffTable, f : Double) -> MathnumericaldiffTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffTable::add(self : MathnumericaldiffTable, other : MathnumericaldiffTable) -> MathnumericaldiffTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffTable::copy(self : MathnumericaldiffTable) -> MathnumericaldiffTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffTable::fill(self : MathnumericaldiffTable, v : Double) -> MathnumericaldiffTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffTable::min(self : MathnumericaldiffTable) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffTable::max(self : MathnumericaldiffTable) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffTable::to_string(self : MathnumericaldiffTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_graphn_make(size : Int) -> MathnumericaldiffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffGraphN::len(self : MathnumericaldiffGraphN) -> Int { self.size }

pub fn MathnumericaldiffGraphN::get(self : MathnumericaldiffGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffGraphN::set(self : MathnumericaldiffGraphN, i : Int, v : Double) -> MathnumericaldiffGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffGraphN::sum(self : MathnumericaldiffGraphN) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffGraphN::mean(self : MathnumericaldiffGraphN) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffGraphN::scale(self : MathnumericaldiffGraphN, f : Double) -> MathnumericaldiffGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffGraphN::add(self : MathnumericaldiffGraphN, other : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffGraphN::copy(self : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffGraphN::fill(self : MathnumericaldiffGraphN, v : Double) -> MathnumericaldiffGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffGraphN::min(self : MathnumericaldiffGraphN) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffGraphN::max(self : MathnumericaldiffGraphN) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffGraphN::to_string(self : MathnumericaldiffGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_node_make(size : Int) -> MathnumericaldiffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffNode::len(self : MathnumericaldiffNode) -> Int { self.size }

pub fn MathnumericaldiffNode::get(self : MathnumericaldiffNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffNode::set(self : MathnumericaldiffNode, i : Int, v : Double) -> MathnumericaldiffNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffNode::sum(self : MathnumericaldiffNode) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffNode::mean(self : MathnumericaldiffNode) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffNode::scale(self : MathnumericaldiffNode, f : Double) -> MathnumericaldiffNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffNode::add(self : MathnumericaldiffNode, other : MathnumericaldiffNode) -> MathnumericaldiffNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffNode::copy(self : MathnumericaldiffNode) -> MathnumericaldiffNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffNode::fill(self : MathnumericaldiffNode, v : Double) -> MathnumericaldiffNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffNode::min(self : MathnumericaldiffNode) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffNode::max(self : MathnumericaldiffNode) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffNode::to_string(self : MathnumericaldiffNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_edge_make(size : Int) -> MathnumericaldiffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffEdge::len(self : MathnumericaldiffEdge) -> Int { self.size }

pub fn MathnumericaldiffEdge::get(self : MathnumericaldiffEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffEdge::set(self : MathnumericaldiffEdge, i : Int, v : Double) -> MathnumericaldiffEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffEdge::sum(self : MathnumericaldiffEdge) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffEdge::mean(self : MathnumericaldiffEdge) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffEdge::scale(self : MathnumericaldiffEdge, f : Double) -> MathnumericaldiffEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffEdge::add(self : MathnumericaldiffEdge, other : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffEdge::copy(self : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffEdge::fill(self : MathnumericaldiffEdge, v : Double) -> MathnumericaldiffEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffEdge::min(self : MathnumericaldiffEdge) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffEdge::max(self : MathnumericaldiffEdge) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffEdge::to_string(self : MathnumericaldiffEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_path_make(size : Int) -> MathnumericaldiffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffPath::len(self : MathnumericaldiffPath) -> Int { self.size }

pub fn MathnumericaldiffPath::get(self : MathnumericaldiffPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffPath::set(self : MathnumericaldiffPath, i : Int, v : Double) -> MathnumericaldiffPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffPath::sum(self : MathnumericaldiffPath) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffPath::mean(self : MathnumericaldiffPath) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffPath::scale(self : MathnumericaldiffPath, f : Double) -> MathnumericaldiffPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffPath::add(self : MathnumericaldiffPath, other : MathnumericaldiffPath) -> MathnumericaldiffPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffPath::copy(self : MathnumericaldiffPath) -> MathnumericaldiffPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffPath::fill(self : MathnumericaldiffPath, v : Double) -> MathnumericaldiffPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffPath::min(self : MathnumericaldiffPath) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffPath::max(self : MathnumericaldiffPath) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffPath::to_string(self : MathnumericaldiffPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cluster_make(size : Int) -> MathnumericaldiffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffCluster::len(self : MathnumericaldiffCluster) -> Int { self.size }

pub fn MathnumericaldiffCluster::get(self : MathnumericaldiffCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffCluster::set(self : MathnumericaldiffCluster, i : Int, v : Double) -> MathnumericaldiffCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCluster::sum(self : MathnumericaldiffCluster) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffCluster::mean(self : MathnumericaldiffCluster) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffCluster::scale(self : MathnumericaldiffCluster, f : Double) -> MathnumericaldiffCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCluster::add(self : MathnumericaldiffCluster, other : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffCluster::copy(self : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCluster::fill(self : MathnumericaldiffCluster, v : Double) -> MathnumericaldiffCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCluster::min(self : MathnumericaldiffCluster) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffCluster::max(self : MathnumericaldiffCluster) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffCluster::to_string(self : MathnumericaldiffCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_model_make(size : Int) -> MathnumericaldiffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffModel::len(self : MathnumericaldiffModel) -> Int { self.size }

pub fn MathnumericaldiffModel::get(self : MathnumericaldiffModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffModel::set(self : MathnumericaldiffModel, i : Int, v : Double) -> MathnumericaldiffModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffModel::sum(self : MathnumericaldiffModel) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffModel::mean(self : MathnumericaldiffModel) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffModel::scale(self : MathnumericaldiffModel, f : Double) -> MathnumericaldiffModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffModel::add(self : MathnumericaldiffModel, other : MathnumericaldiffModel) -> MathnumericaldiffModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffModel::copy(self : MathnumericaldiffModel) -> MathnumericaldiffModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffModel::fill(self : MathnumericaldiffModel, v : Double) -> MathnumericaldiffModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffModel::min(self : MathnumericaldiffModel) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffModel::max(self : MathnumericaldiffModel) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffModel::to_string(self : MathnumericaldiffModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_layer_make(size : Int) -> MathnumericaldiffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffLayer::len(self : MathnumericaldiffLayer) -> Int { self.size }

pub fn MathnumericaldiffLayer::get(self : MathnumericaldiffLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffLayer::set(self : MathnumericaldiffLayer, i : Int, v : Double) -> MathnumericaldiffLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffLayer::sum(self : MathnumericaldiffLayer) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffLayer::mean(self : MathnumericaldiffLayer) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffLayer::scale(self : MathnumericaldiffLayer, f : Double) -> MathnumericaldiffLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffLayer::add(self : MathnumericaldiffLayer, other : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffLayer::copy(self : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffLayer::fill(self : MathnumericaldiffLayer, v : Double) -> MathnumericaldiffLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffLayer::min(self : MathnumericaldiffLayer) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffLayer::max(self : MathnumericaldiffLayer) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffLayer::to_string(self : MathnumericaldiffLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_buffer_make(size : Int) -> MathnumericaldiffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffBuffer::len(self : MathnumericaldiffBuffer) -> Int { self.size }

pub fn MathnumericaldiffBuffer::get(self : MathnumericaldiffBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffBuffer::set(self : MathnumericaldiffBuffer, i : Int, v : Double) -> MathnumericaldiffBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffBuffer::sum(self : MathnumericaldiffBuffer) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffBuffer::mean(self : MathnumericaldiffBuffer) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffBuffer::scale(self : MathnumericaldiffBuffer, f : Double) -> MathnumericaldiffBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffBuffer::add(self : MathnumericaldiffBuffer, other : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffBuffer::copy(self : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffBuffer::fill(self : MathnumericaldiffBuffer, v : Double) -> MathnumericaldiffBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffBuffer::min(self : MathnumericaldiffBuffer) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffBuffer::max(self : MathnumericaldiffBuffer) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffBuffer::to_string(self : MathnumericaldiffBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cursor_make(size : Int) -> MathnumericaldiffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffCursor::len(self : MathnumericaldiffCursor) -> Int { self.size }

pub fn MathnumericaldiffCursor::get(self : MathnumericaldiffCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffCursor::set(self : MathnumericaldiffCursor, i : Int, v : Double) -> MathnumericaldiffCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCursor::sum(self : MathnumericaldiffCursor) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffCursor::mean(self : MathnumericaldiffCursor) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffCursor::scale(self : MathnumericaldiffCursor, f : Double) -> MathnumericaldiffCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCursor::add(self : MathnumericaldiffCursor, other : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffCursor::copy(self : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCursor::fill(self : MathnumericaldiffCursor, v : Double) -> MathnumericaldiffCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffCursor::min(self : MathnumericaldiffCursor) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffCursor::max(self : MathnumericaldiffCursor) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffCursor::to_string(self : MathnumericaldiffCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_view_make(size : Int) -> MathnumericaldiffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffView::len(self : MathnumericaldiffView) -> Int { self.size }

pub fn MathnumericaldiffView::get(self : MathnumericaldiffView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffView::set(self : MathnumericaldiffView, i : Int, v : Double) -> MathnumericaldiffView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffView::sum(self : MathnumericaldiffView) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffView::mean(self : MathnumericaldiffView) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffView::scale(self : MathnumericaldiffView, f : Double) -> MathnumericaldiffView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffView::add(self : MathnumericaldiffView, other : MathnumericaldiffView) -> MathnumericaldiffView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffView::copy(self : MathnumericaldiffView) -> MathnumericaldiffView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffView::fill(self : MathnumericaldiffView, v : Double) -> MathnumericaldiffView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffView::min(self : MathnumericaldiffView) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffView::max(self : MathnumericaldiffView) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffView::to_string(self : MathnumericaldiffView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_range_make(size : Int) -> MathnumericaldiffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffRange::len(self : MathnumericaldiffRange) -> Int { self.size }

pub fn MathnumericaldiffRange::get(self : MathnumericaldiffRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffRange::set(self : MathnumericaldiffRange, i : Int, v : Double) -> MathnumericaldiffRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffRange::sum(self : MathnumericaldiffRange) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffRange::mean(self : MathnumericaldiffRange) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffRange::scale(self : MathnumericaldiffRange, f : Double) -> MathnumericaldiffRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffRange::add(self : MathnumericaldiffRange, other : MathnumericaldiffRange) -> MathnumericaldiffRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffRange::copy(self : MathnumericaldiffRange) -> MathnumericaldiffRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffRange::fill(self : MathnumericaldiffRange, v : Double) -> MathnumericaldiffRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffRange::min(self : MathnumericaldiffRange) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffRange::max(self : MathnumericaldiffRange) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffRange::to_string(self : MathnumericaldiffRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_slice_make(size : Int) -> MathnumericaldiffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericaldiffSlice::len(self : MathnumericaldiffSlice) -> Int { self.size }

pub fn MathnumericaldiffSlice::get(self : MathnumericaldiffSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericaldiffSlice::set(self : MathnumericaldiffSlice, i : Int, v : Double) -> MathnumericaldiffSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffSlice::sum(self : MathnumericaldiffSlice) -> Double { @_common.sum(self.data) }

pub fn MathnumericaldiffSlice::mean(self : MathnumericaldiffSlice) -> Double { @_common.mean(self.data) }

pub fn MathnumericaldiffSlice::scale(self : MathnumericaldiffSlice, f : Double) -> MathnumericaldiffSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffSlice::add(self : MathnumericaldiffSlice, other : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericaldiffSlice::copy(self : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffSlice::fill(self : MathnumericaldiffSlice, v : Double) -> MathnumericaldiffSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericaldiffSlice::min(self : MathnumericaldiffSlice) -> Double { @_common.min(self.data) }

pub fn MathnumericaldiffSlice::max(self : MathnumericaldiffSlice) -> Double { @_common.max(self.data) }

pub fn MathnumericaldiffSlice::to_string(self : MathnumericaldiffSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

