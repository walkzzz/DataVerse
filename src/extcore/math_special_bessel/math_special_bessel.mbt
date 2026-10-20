///===
/// extcore/math_special_bessel

pub(all) struct MathspecialbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_bessel_make_point(x : Double, y : Double) -> MathspecialbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_bessel_make_point3(x : Double, y : Double, z : Double) -> MathspecialbesselPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialbesselPoint::x(self : MathspecialbesselPoint) -> Double { self.x }

pub fn MathspecialbesselPoint::y(self : MathspecialbesselPoint) -> Double { self.y }

pub fn MathspecialbesselPoint::z(self : MathspecialbesselPoint) -> Double { self.z }

pub fn MathspecialbesselPoint::label(self : MathspecialbesselPoint) -> Int { self.label }

pub fn MathspecialbesselPoint::dist(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialbesselPoint::add(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialbesselPoint::sub(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialbesselPoint::scale(self : MathspecialbesselPoint, s : Double) -> MathspecialbesselPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialbesselPoint::dot(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialbesselPoint::cross(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialbesselPoint::norm(self : MathspecialbesselPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialbesselPoint::normalize(self : MathspecialbesselPoint) -> MathspecialbesselPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbesselPoint::negate(self : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialbesselPoint::mid(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialbesselPoint::lerp(self : MathspecialbesselPoint, other : MathspecialbesselPoint, t : Double) -> MathspecialbesselPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialbesselPoint::to_string(self : MathspecialbesselPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_bessel_make_series(vals : Array[Double], name : String) -> MathspecialbesselSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialbesselSeries::len(self : MathspecialbesselSeries) -> Int { self.vals.length() }

pub fn MathspecialbesselSeries::sum(self : MathspecialbesselSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialbesselSeries::mean(self : MathspecialbesselSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialbesselSeries::min(self : MathspecialbesselSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialbesselSeries::max(self : MathspecialbesselSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialbesselSeries::range(self : MathspecialbesselSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialbesselSeries::variance(self : MathspecialbesselSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialbesselSeries::std(self : MathspecialbesselSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialbesselSeries::median(self : MathspecialbesselSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialbesselSeries::scale(self : MathspecialbesselSeries, f : Double) -> MathspecialbesselSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::add(self : MathspecialbesselSeries, other : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::sub(self : MathspecialbesselSeries, other : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::normalize(self : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialbesselSeries::cumsum(self : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialbesselSeries::to_string(self : MathspecialbesselSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbesselMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_bessel_matrix_identity(n : Int) -> MathspecialbesselMatrix {
  let m = math_special_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialbesselMatrix::get(self : MathspecialbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialbesselMatrix::transpose(self : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialbesselMatrix::add(self : MathspecialbesselMatrix, other : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialbesselMatrix::scale(self : MathspecialbesselMatrix, s : Double) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialbesselMatrix::multiply(self : MathspecialbesselMatrix, other : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if self.cols != other.rows { return math_special_bessel_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_bessel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathspecialbesselMatrix::trace(self : MathspecialbesselMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialbesselMatrix::det(self : MathspecialbesselMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialbesselMatrix::norm(self : MathspecialbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialbesselMatrix::to_string(self : MathspecialbesselMatrix) -> String {
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

pub(all) struct MathspecialbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_bessel_make_vector(comps : Array[Double]) -> MathspecialbesselVector {
  { comps, dim: comps.length() }
}

pub fn math_special_bessel_vector_zero(dim : Int) -> MathspecialbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialbesselVector::add(self : MathspecialbesselVector, other : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbesselVector::sub(self : MathspecialbesselVector, other : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbesselVector::scale(self : MathspecialbesselVector, s : Double) -> MathspecialbesselVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialbesselVector::dot(self : MathspecialbesselVector, other : MathspecialbesselVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialbesselVector::norm(self : MathspecialbesselVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialbesselVector::normalize(self : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbesselVector::dist(self : MathspecialbesselVector, other : MathspecialbesselVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialbesselVector::to_string(self : MathspecialbesselVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_frame_make(size : Int) -> MathspecialbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselFrame::len(self : MathspecialbesselFrame) -> Int { self.size }

pub fn MathspecialbesselFrame::get(self : MathspecialbesselFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselFrame::set(self : MathspecialbesselFrame, i : Int, v : Double) -> MathspecialbesselFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselFrame::sum(self : MathspecialbesselFrame) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselFrame::mean(self : MathspecialbesselFrame) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselFrame::scale(self : MathspecialbesselFrame, f : Double) -> MathspecialbesselFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselFrame::add(self : MathspecialbesselFrame, other : MathspecialbesselFrame) -> MathspecialbesselFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselFrame::copy(self : MathspecialbesselFrame) -> MathspecialbesselFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselFrame::fill(self : MathspecialbesselFrame, v : Double) -> MathspecialbesselFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselFrame::min(self : MathspecialbesselFrame) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselFrame::max(self : MathspecialbesselFrame) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselFrame::to_string(self : MathspecialbesselFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_table_make(size : Int) -> MathspecialbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselTable::len(self : MathspecialbesselTable) -> Int { self.size }

pub fn MathspecialbesselTable::get(self : MathspecialbesselTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselTable::set(self : MathspecialbesselTable, i : Int, v : Double) -> MathspecialbesselTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselTable::sum(self : MathspecialbesselTable) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselTable::mean(self : MathspecialbesselTable) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselTable::scale(self : MathspecialbesselTable, f : Double) -> MathspecialbesselTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselTable::add(self : MathspecialbesselTable, other : MathspecialbesselTable) -> MathspecialbesselTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselTable::copy(self : MathspecialbesselTable) -> MathspecialbesselTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselTable::fill(self : MathspecialbesselTable, v : Double) -> MathspecialbesselTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselTable::min(self : MathspecialbesselTable) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselTable::max(self : MathspecialbesselTable) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselTable::to_string(self : MathspecialbesselTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_graphn_make(size : Int) -> MathspecialbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselGraphN::len(self : MathspecialbesselGraphN) -> Int { self.size }

pub fn MathspecialbesselGraphN::get(self : MathspecialbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselGraphN::set(self : MathspecialbesselGraphN, i : Int, v : Double) -> MathspecialbesselGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselGraphN::sum(self : MathspecialbesselGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselGraphN::mean(self : MathspecialbesselGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselGraphN::scale(self : MathspecialbesselGraphN, f : Double) -> MathspecialbesselGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselGraphN::add(self : MathspecialbesselGraphN, other : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselGraphN::copy(self : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselGraphN::fill(self : MathspecialbesselGraphN, v : Double) -> MathspecialbesselGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselGraphN::min(self : MathspecialbesselGraphN) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselGraphN::max(self : MathspecialbesselGraphN) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselGraphN::to_string(self : MathspecialbesselGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_node_make(size : Int) -> MathspecialbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselNode::len(self : MathspecialbesselNode) -> Int { self.size }

pub fn MathspecialbesselNode::get(self : MathspecialbesselNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselNode::set(self : MathspecialbesselNode, i : Int, v : Double) -> MathspecialbesselNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselNode::sum(self : MathspecialbesselNode) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselNode::mean(self : MathspecialbesselNode) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselNode::scale(self : MathspecialbesselNode, f : Double) -> MathspecialbesselNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselNode::add(self : MathspecialbesselNode, other : MathspecialbesselNode) -> MathspecialbesselNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselNode::copy(self : MathspecialbesselNode) -> MathspecialbesselNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselNode::fill(self : MathspecialbesselNode, v : Double) -> MathspecialbesselNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselNode::min(self : MathspecialbesselNode) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselNode::max(self : MathspecialbesselNode) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselNode::to_string(self : MathspecialbesselNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_edge_make(size : Int) -> MathspecialbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselEdge::len(self : MathspecialbesselEdge) -> Int { self.size }

pub fn MathspecialbesselEdge::get(self : MathspecialbesselEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselEdge::set(self : MathspecialbesselEdge, i : Int, v : Double) -> MathspecialbesselEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselEdge::sum(self : MathspecialbesselEdge) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselEdge::mean(self : MathspecialbesselEdge) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselEdge::scale(self : MathspecialbesselEdge, f : Double) -> MathspecialbesselEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselEdge::add(self : MathspecialbesselEdge, other : MathspecialbesselEdge) -> MathspecialbesselEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselEdge::copy(self : MathspecialbesselEdge) -> MathspecialbesselEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselEdge::fill(self : MathspecialbesselEdge, v : Double) -> MathspecialbesselEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselEdge::min(self : MathspecialbesselEdge) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselEdge::max(self : MathspecialbesselEdge) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselEdge::to_string(self : MathspecialbesselEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_path_make(size : Int) -> MathspecialbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselPath::len(self : MathspecialbesselPath) -> Int { self.size }

pub fn MathspecialbesselPath::get(self : MathspecialbesselPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselPath::set(self : MathspecialbesselPath, i : Int, v : Double) -> MathspecialbesselPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselPath::sum(self : MathspecialbesselPath) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselPath::mean(self : MathspecialbesselPath) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselPath::scale(self : MathspecialbesselPath, f : Double) -> MathspecialbesselPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselPath::add(self : MathspecialbesselPath, other : MathspecialbesselPath) -> MathspecialbesselPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselPath::copy(self : MathspecialbesselPath) -> MathspecialbesselPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselPath::fill(self : MathspecialbesselPath, v : Double) -> MathspecialbesselPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselPath::min(self : MathspecialbesselPath) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselPath::max(self : MathspecialbesselPath) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselPath::to_string(self : MathspecialbesselPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cluster_make(size : Int) -> MathspecialbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselCluster::len(self : MathspecialbesselCluster) -> Int { self.size }

pub fn MathspecialbesselCluster::get(self : MathspecialbesselCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselCluster::set(self : MathspecialbesselCluster, i : Int, v : Double) -> MathspecialbesselCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCluster::sum(self : MathspecialbesselCluster) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselCluster::mean(self : MathspecialbesselCluster) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselCluster::scale(self : MathspecialbesselCluster, f : Double) -> MathspecialbesselCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCluster::add(self : MathspecialbesselCluster, other : MathspecialbesselCluster) -> MathspecialbesselCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselCluster::copy(self : MathspecialbesselCluster) -> MathspecialbesselCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCluster::fill(self : MathspecialbesselCluster, v : Double) -> MathspecialbesselCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCluster::min(self : MathspecialbesselCluster) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselCluster::max(self : MathspecialbesselCluster) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselCluster::to_string(self : MathspecialbesselCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_model_make(size : Int) -> MathspecialbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselModel::len(self : MathspecialbesselModel) -> Int { self.size }

pub fn MathspecialbesselModel::get(self : MathspecialbesselModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselModel::set(self : MathspecialbesselModel, i : Int, v : Double) -> MathspecialbesselModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselModel::sum(self : MathspecialbesselModel) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselModel::mean(self : MathspecialbesselModel) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselModel::scale(self : MathspecialbesselModel, f : Double) -> MathspecialbesselModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselModel::add(self : MathspecialbesselModel, other : MathspecialbesselModel) -> MathspecialbesselModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselModel::copy(self : MathspecialbesselModel) -> MathspecialbesselModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselModel::fill(self : MathspecialbesselModel, v : Double) -> MathspecialbesselModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselModel::min(self : MathspecialbesselModel) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselModel::max(self : MathspecialbesselModel) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselModel::to_string(self : MathspecialbesselModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_layer_make(size : Int) -> MathspecialbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselLayer::len(self : MathspecialbesselLayer) -> Int { self.size }

pub fn MathspecialbesselLayer::get(self : MathspecialbesselLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselLayer::set(self : MathspecialbesselLayer, i : Int, v : Double) -> MathspecialbesselLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselLayer::sum(self : MathspecialbesselLayer) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselLayer::mean(self : MathspecialbesselLayer) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselLayer::scale(self : MathspecialbesselLayer, f : Double) -> MathspecialbesselLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselLayer::add(self : MathspecialbesselLayer, other : MathspecialbesselLayer) -> MathspecialbesselLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselLayer::copy(self : MathspecialbesselLayer) -> MathspecialbesselLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselLayer::fill(self : MathspecialbesselLayer, v : Double) -> MathspecialbesselLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselLayer::min(self : MathspecialbesselLayer) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselLayer::max(self : MathspecialbesselLayer) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselLayer::to_string(self : MathspecialbesselLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_buffer_make(size : Int) -> MathspecialbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselBuffer::len(self : MathspecialbesselBuffer) -> Int { self.size }

pub fn MathspecialbesselBuffer::get(self : MathspecialbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselBuffer::set(self : MathspecialbesselBuffer, i : Int, v : Double) -> MathspecialbesselBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselBuffer::sum(self : MathspecialbesselBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselBuffer::mean(self : MathspecialbesselBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselBuffer::scale(self : MathspecialbesselBuffer, f : Double) -> MathspecialbesselBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselBuffer::add(self : MathspecialbesselBuffer, other : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselBuffer::copy(self : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselBuffer::fill(self : MathspecialbesselBuffer, v : Double) -> MathspecialbesselBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselBuffer::min(self : MathspecialbesselBuffer) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselBuffer::max(self : MathspecialbesselBuffer) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselBuffer::to_string(self : MathspecialbesselBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cursor_make(size : Int) -> MathspecialbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselCursor::len(self : MathspecialbesselCursor) -> Int { self.size }

pub fn MathspecialbesselCursor::get(self : MathspecialbesselCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselCursor::set(self : MathspecialbesselCursor, i : Int, v : Double) -> MathspecialbesselCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCursor::sum(self : MathspecialbesselCursor) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselCursor::mean(self : MathspecialbesselCursor) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselCursor::scale(self : MathspecialbesselCursor, f : Double) -> MathspecialbesselCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCursor::add(self : MathspecialbesselCursor, other : MathspecialbesselCursor) -> MathspecialbesselCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselCursor::copy(self : MathspecialbesselCursor) -> MathspecialbesselCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCursor::fill(self : MathspecialbesselCursor, v : Double) -> MathspecialbesselCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselCursor::min(self : MathspecialbesselCursor) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselCursor::max(self : MathspecialbesselCursor) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselCursor::to_string(self : MathspecialbesselCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_view_make(size : Int) -> MathspecialbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselView::len(self : MathspecialbesselView) -> Int { self.size }

pub fn MathspecialbesselView::get(self : MathspecialbesselView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselView::set(self : MathspecialbesselView, i : Int, v : Double) -> MathspecialbesselView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselView::sum(self : MathspecialbesselView) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselView::mean(self : MathspecialbesselView) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselView::scale(self : MathspecialbesselView, f : Double) -> MathspecialbesselView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselView::add(self : MathspecialbesselView, other : MathspecialbesselView) -> MathspecialbesselView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselView::copy(self : MathspecialbesselView) -> MathspecialbesselView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselView::fill(self : MathspecialbesselView, v : Double) -> MathspecialbesselView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselView::min(self : MathspecialbesselView) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselView::max(self : MathspecialbesselView) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselView::to_string(self : MathspecialbesselView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_range_make(size : Int) -> MathspecialbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselRange::len(self : MathspecialbesselRange) -> Int { self.size }

pub fn MathspecialbesselRange::get(self : MathspecialbesselRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselRange::set(self : MathspecialbesselRange, i : Int, v : Double) -> MathspecialbesselRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselRange::sum(self : MathspecialbesselRange) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselRange::mean(self : MathspecialbesselRange) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselRange::scale(self : MathspecialbesselRange, f : Double) -> MathspecialbesselRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselRange::add(self : MathspecialbesselRange, other : MathspecialbesselRange) -> MathspecialbesselRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselRange::copy(self : MathspecialbesselRange) -> MathspecialbesselRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselRange::fill(self : MathspecialbesselRange, v : Double) -> MathspecialbesselRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselRange::min(self : MathspecialbesselRange) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselRange::max(self : MathspecialbesselRange) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselRange::to_string(self : MathspecialbesselRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_slice_make(size : Int) -> MathspecialbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbesselSlice::len(self : MathspecialbesselSlice) -> Int { self.size }

pub fn MathspecialbesselSlice::get(self : MathspecialbesselSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbesselSlice::set(self : MathspecialbesselSlice, i : Int, v : Double) -> MathspecialbesselSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbesselSlice::sum(self : MathspecialbesselSlice) -> Double { @_common.sum(self.data) }

pub fn MathspecialbesselSlice::mean(self : MathspecialbesselSlice) -> Double { @_common.mean(self.data) }

pub fn MathspecialbesselSlice::scale(self : MathspecialbesselSlice, f : Double) -> MathspecialbesselSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselSlice::add(self : MathspecialbesselSlice, other : MathspecialbesselSlice) -> MathspecialbesselSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbesselSlice::copy(self : MathspecialbesselSlice) -> MathspecialbesselSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselSlice::fill(self : MathspecialbesselSlice, v : Double) -> MathspecialbesselSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbesselSlice::min(self : MathspecialbesselSlice) -> Double { @_common.min(self.data) }

pub fn MathspecialbesselSlice::max(self : MathspecialbesselSlice) -> Double { @_common.max(self.data) }

pub fn MathspecialbesselSlice::to_string(self : MathspecialbesselSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

