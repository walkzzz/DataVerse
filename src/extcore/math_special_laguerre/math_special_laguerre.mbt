///===
/// extcore/math_special_laguerre

pub(all) struct MathspeciallaguerrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_laguerre_make_point(x : Double, y : Double) -> MathspeciallaguerrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_laguerre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallaguerrePoint {
  { x, y, z, label: 0 }
}

pub fn MathspeciallaguerrePoint::x(self : MathspeciallaguerrePoint) -> Double { self.x }

pub fn MathspeciallaguerrePoint::y(self : MathspeciallaguerrePoint) -> Double { self.y }

pub fn MathspeciallaguerrePoint::z(self : MathspeciallaguerrePoint) -> Double { self.z }

pub fn MathspeciallaguerrePoint::label(self : MathspeciallaguerrePoint) -> Int { self.label }

pub fn MathspeciallaguerrePoint::dist(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspeciallaguerrePoint::add(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::sub(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::scale(self : MathspeciallaguerrePoint, s : Double) -> MathspeciallaguerrePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspeciallaguerrePoint::dot(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspeciallaguerrePoint::cross(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspeciallaguerrePoint::norm(self : MathspeciallaguerrePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspeciallaguerrePoint::normalize(self : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallaguerrePoint::negate(self : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::mid(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspeciallaguerrePoint::lerp(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint, t : Double) -> MathspeciallaguerrePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspeciallaguerrePoint::to_string(self : MathspeciallaguerrePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_laguerre_make_series(vals : Array[Double], name : String) -> MathspeciallaguerreSeries {
  { vals, name, meta: 0 }
}

pub fn MathspeciallaguerreSeries::len(self : MathspeciallaguerreSeries) -> Int { self.vals.length() }

pub fn MathspeciallaguerreSeries::sum(self : MathspeciallaguerreSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspeciallaguerreSeries::mean(self : MathspeciallaguerreSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspeciallaguerreSeries::min(self : MathspeciallaguerreSeries) -> Double { @_common.min(self.vals) }

pub fn MathspeciallaguerreSeries::max(self : MathspeciallaguerreSeries) -> Double { @_common.max(self.vals) }

pub fn MathspeciallaguerreSeries::range(self : MathspeciallaguerreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspeciallaguerreSeries::variance(self : MathspeciallaguerreSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspeciallaguerreSeries::std(self : MathspeciallaguerreSeries) -> Double { @_common.std(self.vals) }

pub fn MathspeciallaguerreSeries::median(self : MathspeciallaguerreSeries) -> Double { @_common.median(self.vals) }

pub fn MathspeciallaguerreSeries::scale(self : MathspeciallaguerreSeries, f : Double) -> MathspeciallaguerreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::add(self : MathspeciallaguerreSeries, other : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::sub(self : MathspeciallaguerreSeries, other : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::normalize(self : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspeciallaguerreSeries::cumsum(self : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspeciallaguerreSeries::to_string(self : MathspeciallaguerreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallaguerreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_laguerre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallaguerreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_laguerre_matrix_identity(n : Int) -> MathspeciallaguerreMatrix {
  let m = math_special_laguerre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspeciallaguerreMatrix::get(self : MathspeciallaguerreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspeciallaguerreMatrix::transpose(self : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspeciallaguerreMatrix::add(self : MathspeciallaguerreMatrix, other : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_laguerre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspeciallaguerreMatrix::scale(self : MathspeciallaguerreMatrix, s : Double) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspeciallaguerreMatrix::multiply(self : MathspeciallaguerreMatrix, other : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if self.cols != other.rows { return math_special_laguerre_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_laguerre_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathspeciallaguerreMatrix::trace(self : MathspeciallaguerreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspeciallaguerreMatrix::det(self : MathspeciallaguerreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspeciallaguerreMatrix::norm(self : MathspeciallaguerreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspeciallaguerreMatrix::to_string(self : MathspeciallaguerreMatrix) -> String {
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

pub(all) struct MathspeciallaguerreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_laguerre_make_vector(comps : Array[Double]) -> MathspeciallaguerreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_laguerre_vector_zero(dim : Int) -> MathspeciallaguerreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspeciallaguerreVector::add(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallaguerreVector::sub(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallaguerreVector::scale(self : MathspeciallaguerreVector, s : Double) -> MathspeciallaguerreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspeciallaguerreVector::dot(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspeciallaguerreVector::norm(self : MathspeciallaguerreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspeciallaguerreVector::normalize(self : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallaguerreVector::dist(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspeciallaguerreVector::to_string(self : MathspeciallaguerreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallaguerreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_frame_make(size : Int) -> MathspeciallaguerreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreFrame::len(self : MathspeciallaguerreFrame) -> Int { self.size }

pub fn MathspeciallaguerreFrame::get(self : MathspeciallaguerreFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreFrame::set(self : MathspeciallaguerreFrame, i : Int, v : Double) -> MathspeciallaguerreFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreFrame::sum(self : MathspeciallaguerreFrame) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreFrame::mean(self : MathspeciallaguerreFrame) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreFrame::scale(self : MathspeciallaguerreFrame, f : Double) -> MathspeciallaguerreFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreFrame::add(self : MathspeciallaguerreFrame, other : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreFrame::copy(self : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreFrame::fill(self : MathspeciallaguerreFrame, v : Double) -> MathspeciallaguerreFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreFrame::min(self : MathspeciallaguerreFrame) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreFrame::max(self : MathspeciallaguerreFrame) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreFrame::to_string(self : MathspeciallaguerreFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_table_make(size : Int) -> MathspeciallaguerreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreTable::len(self : MathspeciallaguerreTable) -> Int { self.size }

pub fn MathspeciallaguerreTable::get(self : MathspeciallaguerreTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreTable::set(self : MathspeciallaguerreTable, i : Int, v : Double) -> MathspeciallaguerreTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreTable::sum(self : MathspeciallaguerreTable) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreTable::mean(self : MathspeciallaguerreTable) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreTable::scale(self : MathspeciallaguerreTable, f : Double) -> MathspeciallaguerreTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreTable::add(self : MathspeciallaguerreTable, other : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreTable::copy(self : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreTable::fill(self : MathspeciallaguerreTable, v : Double) -> MathspeciallaguerreTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreTable::min(self : MathspeciallaguerreTable) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreTable::max(self : MathspeciallaguerreTable) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreTable::to_string(self : MathspeciallaguerreTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_graphn_make(size : Int) -> MathspeciallaguerreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreGraphN::len(self : MathspeciallaguerreGraphN) -> Int { self.size }

pub fn MathspeciallaguerreGraphN::get(self : MathspeciallaguerreGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreGraphN::set(self : MathspeciallaguerreGraphN, i : Int, v : Double) -> MathspeciallaguerreGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreGraphN::sum(self : MathspeciallaguerreGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreGraphN::mean(self : MathspeciallaguerreGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreGraphN::scale(self : MathspeciallaguerreGraphN, f : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreGraphN::add(self : MathspeciallaguerreGraphN, other : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreGraphN::copy(self : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreGraphN::fill(self : MathspeciallaguerreGraphN, v : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreGraphN::min(self : MathspeciallaguerreGraphN) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreGraphN::max(self : MathspeciallaguerreGraphN) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreGraphN::to_string(self : MathspeciallaguerreGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_node_make(size : Int) -> MathspeciallaguerreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreNode::len(self : MathspeciallaguerreNode) -> Int { self.size }

pub fn MathspeciallaguerreNode::get(self : MathspeciallaguerreNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreNode::set(self : MathspeciallaguerreNode, i : Int, v : Double) -> MathspeciallaguerreNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreNode::sum(self : MathspeciallaguerreNode) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreNode::mean(self : MathspeciallaguerreNode) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreNode::scale(self : MathspeciallaguerreNode, f : Double) -> MathspeciallaguerreNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreNode::add(self : MathspeciallaguerreNode, other : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreNode::copy(self : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreNode::fill(self : MathspeciallaguerreNode, v : Double) -> MathspeciallaguerreNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreNode::min(self : MathspeciallaguerreNode) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreNode::max(self : MathspeciallaguerreNode) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreNode::to_string(self : MathspeciallaguerreNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_edge_make(size : Int) -> MathspeciallaguerreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreEdge::len(self : MathspeciallaguerreEdge) -> Int { self.size }

pub fn MathspeciallaguerreEdge::get(self : MathspeciallaguerreEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreEdge::set(self : MathspeciallaguerreEdge, i : Int, v : Double) -> MathspeciallaguerreEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreEdge::sum(self : MathspeciallaguerreEdge) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreEdge::mean(self : MathspeciallaguerreEdge) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreEdge::scale(self : MathspeciallaguerreEdge, f : Double) -> MathspeciallaguerreEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreEdge::add(self : MathspeciallaguerreEdge, other : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreEdge::copy(self : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreEdge::fill(self : MathspeciallaguerreEdge, v : Double) -> MathspeciallaguerreEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreEdge::min(self : MathspeciallaguerreEdge) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreEdge::max(self : MathspeciallaguerreEdge) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreEdge::to_string(self : MathspeciallaguerreEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_path_make(size : Int) -> MathspeciallaguerrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerrePath::len(self : MathspeciallaguerrePath) -> Int { self.size }

pub fn MathspeciallaguerrePath::get(self : MathspeciallaguerrePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerrePath::set(self : MathspeciallaguerrePath, i : Int, v : Double) -> MathspeciallaguerrePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerrePath::sum(self : MathspeciallaguerrePath) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerrePath::mean(self : MathspeciallaguerrePath) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerrePath::scale(self : MathspeciallaguerrePath, f : Double) -> MathspeciallaguerrePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerrePath::add(self : MathspeciallaguerrePath, other : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerrePath::copy(self : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerrePath::fill(self : MathspeciallaguerrePath, v : Double) -> MathspeciallaguerrePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerrePath::min(self : MathspeciallaguerrePath) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerrePath::max(self : MathspeciallaguerrePath) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerrePath::to_string(self : MathspeciallaguerrePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cluster_make(size : Int) -> MathspeciallaguerreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreCluster::len(self : MathspeciallaguerreCluster) -> Int { self.size }

pub fn MathspeciallaguerreCluster::get(self : MathspeciallaguerreCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreCluster::set(self : MathspeciallaguerreCluster, i : Int, v : Double) -> MathspeciallaguerreCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCluster::sum(self : MathspeciallaguerreCluster) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreCluster::mean(self : MathspeciallaguerreCluster) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreCluster::scale(self : MathspeciallaguerreCluster, f : Double) -> MathspeciallaguerreCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCluster::add(self : MathspeciallaguerreCluster, other : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreCluster::copy(self : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCluster::fill(self : MathspeciallaguerreCluster, v : Double) -> MathspeciallaguerreCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCluster::min(self : MathspeciallaguerreCluster) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreCluster::max(self : MathspeciallaguerreCluster) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreCluster::to_string(self : MathspeciallaguerreCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_model_make(size : Int) -> MathspeciallaguerreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreModel::len(self : MathspeciallaguerreModel) -> Int { self.size }

pub fn MathspeciallaguerreModel::get(self : MathspeciallaguerreModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreModel::set(self : MathspeciallaguerreModel, i : Int, v : Double) -> MathspeciallaguerreModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreModel::sum(self : MathspeciallaguerreModel) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreModel::mean(self : MathspeciallaguerreModel) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreModel::scale(self : MathspeciallaguerreModel, f : Double) -> MathspeciallaguerreModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreModel::add(self : MathspeciallaguerreModel, other : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreModel::copy(self : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreModel::fill(self : MathspeciallaguerreModel, v : Double) -> MathspeciallaguerreModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreModel::min(self : MathspeciallaguerreModel) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreModel::max(self : MathspeciallaguerreModel) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreModel::to_string(self : MathspeciallaguerreModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_layer_make(size : Int) -> MathspeciallaguerreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreLayer::len(self : MathspeciallaguerreLayer) -> Int { self.size }

pub fn MathspeciallaguerreLayer::get(self : MathspeciallaguerreLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreLayer::set(self : MathspeciallaguerreLayer, i : Int, v : Double) -> MathspeciallaguerreLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreLayer::sum(self : MathspeciallaguerreLayer) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreLayer::mean(self : MathspeciallaguerreLayer) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreLayer::scale(self : MathspeciallaguerreLayer, f : Double) -> MathspeciallaguerreLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreLayer::add(self : MathspeciallaguerreLayer, other : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreLayer::copy(self : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreLayer::fill(self : MathspeciallaguerreLayer, v : Double) -> MathspeciallaguerreLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreLayer::min(self : MathspeciallaguerreLayer) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreLayer::max(self : MathspeciallaguerreLayer) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreLayer::to_string(self : MathspeciallaguerreLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_buffer_make(size : Int) -> MathspeciallaguerreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreBuffer::len(self : MathspeciallaguerreBuffer) -> Int { self.size }

pub fn MathspeciallaguerreBuffer::get(self : MathspeciallaguerreBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreBuffer::set(self : MathspeciallaguerreBuffer, i : Int, v : Double) -> MathspeciallaguerreBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreBuffer::sum(self : MathspeciallaguerreBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreBuffer::mean(self : MathspeciallaguerreBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreBuffer::scale(self : MathspeciallaguerreBuffer, f : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreBuffer::add(self : MathspeciallaguerreBuffer, other : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreBuffer::copy(self : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreBuffer::fill(self : MathspeciallaguerreBuffer, v : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreBuffer::min(self : MathspeciallaguerreBuffer) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreBuffer::max(self : MathspeciallaguerreBuffer) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreBuffer::to_string(self : MathspeciallaguerreBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cursor_make(size : Int) -> MathspeciallaguerreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreCursor::len(self : MathspeciallaguerreCursor) -> Int { self.size }

pub fn MathspeciallaguerreCursor::get(self : MathspeciallaguerreCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreCursor::set(self : MathspeciallaguerreCursor, i : Int, v : Double) -> MathspeciallaguerreCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCursor::sum(self : MathspeciallaguerreCursor) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreCursor::mean(self : MathspeciallaguerreCursor) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreCursor::scale(self : MathspeciallaguerreCursor, f : Double) -> MathspeciallaguerreCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCursor::add(self : MathspeciallaguerreCursor, other : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreCursor::copy(self : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCursor::fill(self : MathspeciallaguerreCursor, v : Double) -> MathspeciallaguerreCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreCursor::min(self : MathspeciallaguerreCursor) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreCursor::max(self : MathspeciallaguerreCursor) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreCursor::to_string(self : MathspeciallaguerreCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_view_make(size : Int) -> MathspeciallaguerreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreView::len(self : MathspeciallaguerreView) -> Int { self.size }

pub fn MathspeciallaguerreView::get(self : MathspeciallaguerreView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreView::set(self : MathspeciallaguerreView, i : Int, v : Double) -> MathspeciallaguerreView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreView::sum(self : MathspeciallaguerreView) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreView::mean(self : MathspeciallaguerreView) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreView::scale(self : MathspeciallaguerreView, f : Double) -> MathspeciallaguerreView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreView::add(self : MathspeciallaguerreView, other : MathspeciallaguerreView) -> MathspeciallaguerreView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreView::copy(self : MathspeciallaguerreView) -> MathspeciallaguerreView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreView::fill(self : MathspeciallaguerreView, v : Double) -> MathspeciallaguerreView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreView::min(self : MathspeciallaguerreView) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreView::max(self : MathspeciallaguerreView) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreView::to_string(self : MathspeciallaguerreView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_range_make(size : Int) -> MathspeciallaguerreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreRange::len(self : MathspeciallaguerreRange) -> Int { self.size }

pub fn MathspeciallaguerreRange::get(self : MathspeciallaguerreRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreRange::set(self : MathspeciallaguerreRange, i : Int, v : Double) -> MathspeciallaguerreRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreRange::sum(self : MathspeciallaguerreRange) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreRange::mean(self : MathspeciallaguerreRange) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreRange::scale(self : MathspeciallaguerreRange, f : Double) -> MathspeciallaguerreRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreRange::add(self : MathspeciallaguerreRange, other : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreRange::copy(self : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreRange::fill(self : MathspeciallaguerreRange, v : Double) -> MathspeciallaguerreRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreRange::min(self : MathspeciallaguerreRange) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreRange::max(self : MathspeciallaguerreRange) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreRange::to_string(self : MathspeciallaguerreRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_slice_make(size : Int) -> MathspeciallaguerreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallaguerreSlice::len(self : MathspeciallaguerreSlice) -> Int { self.size }

pub fn MathspeciallaguerreSlice::get(self : MathspeciallaguerreSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallaguerreSlice::set(self : MathspeciallaguerreSlice, i : Int, v : Double) -> MathspeciallaguerreSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreSlice::sum(self : MathspeciallaguerreSlice) -> Double { @_common.sum(self.data) }

pub fn MathspeciallaguerreSlice::mean(self : MathspeciallaguerreSlice) -> Double { @_common.mean(self.data) }

pub fn MathspeciallaguerreSlice::scale(self : MathspeciallaguerreSlice, f : Double) -> MathspeciallaguerreSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreSlice::add(self : MathspeciallaguerreSlice, other : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallaguerreSlice::copy(self : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreSlice::fill(self : MathspeciallaguerreSlice, v : Double) -> MathspeciallaguerreSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallaguerreSlice::min(self : MathspeciallaguerreSlice) -> Double { @_common.min(self.data) }

pub fn MathspeciallaguerreSlice::max(self : MathspeciallaguerreSlice) -> Double { @_common.max(self.data) }

pub fn MathspeciallaguerreSlice::to_string(self : MathspeciallaguerreSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

