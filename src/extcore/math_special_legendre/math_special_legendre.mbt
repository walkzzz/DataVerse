///===
/// extcore/math_special_legendre

pub(all) struct MathspeciallegendrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_legendre_make_point(x : Double, y : Double) -> MathspeciallegendrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_legendre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallegendrePoint {
  { x, y, z, label: 0 }
}

pub fn MathspeciallegendrePoint::x(self : MathspeciallegendrePoint) -> Double { self.x }

pub fn MathspeciallegendrePoint::y(self : MathspeciallegendrePoint) -> Double { self.y }

pub fn MathspeciallegendrePoint::z(self : MathspeciallegendrePoint) -> Double { self.z }

pub fn MathspeciallegendrePoint::label(self : MathspeciallegendrePoint) -> Int { self.label }

pub fn MathspeciallegendrePoint::dist(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspeciallegendrePoint::add(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspeciallegendrePoint::sub(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspeciallegendrePoint::scale(self : MathspeciallegendrePoint, s : Double) -> MathspeciallegendrePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspeciallegendrePoint::dot(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspeciallegendrePoint::cross(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspeciallegendrePoint::norm(self : MathspeciallegendrePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspeciallegendrePoint::normalize(self : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallegendrePoint::negate(self : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspeciallegendrePoint::mid(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspeciallegendrePoint::lerp(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint, t : Double) -> MathspeciallegendrePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspeciallegendrePoint::to_string(self : MathspeciallegendrePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspeciallegendreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_legendre_make_series(vals : Array[Double], name : String) -> MathspeciallegendreSeries {
  { vals, name, meta: 0 }
}

pub fn MathspeciallegendreSeries::len(self : MathspeciallegendreSeries) -> Int { self.vals.length() }

pub fn MathspeciallegendreSeries::sum(self : MathspeciallegendreSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspeciallegendreSeries::mean(self : MathspeciallegendreSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspeciallegendreSeries::min(self : MathspeciallegendreSeries) -> Double { @_common.min(self.vals) }

pub fn MathspeciallegendreSeries::max(self : MathspeciallegendreSeries) -> Double { @_common.max(self.vals) }

pub fn MathspeciallegendreSeries::range(self : MathspeciallegendreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspeciallegendreSeries::variance(self : MathspeciallegendreSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspeciallegendreSeries::std(self : MathspeciallegendreSeries) -> Double { @_common.std(self.vals) }

pub fn MathspeciallegendreSeries::median(self : MathspeciallegendreSeries) -> Double { @_common.median(self.vals) }

pub fn MathspeciallegendreSeries::scale(self : MathspeciallegendreSeries, f : Double) -> MathspeciallegendreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::add(self : MathspeciallegendreSeries, other : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::sub(self : MathspeciallegendreSeries, other : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::normalize(self : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspeciallegendreSeries::cumsum(self : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspeciallegendreSeries::to_string(self : MathspeciallegendreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallegendreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_legendre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallegendreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_legendre_matrix_identity(n : Int) -> MathspeciallegendreMatrix {
  let m = math_special_legendre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspeciallegendreMatrix::get(self : MathspeciallegendreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspeciallegendreMatrix::transpose(self : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspeciallegendreMatrix::add(self : MathspeciallegendreMatrix, other : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_legendre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspeciallegendreMatrix::scale(self : MathspeciallegendreMatrix, s : Double) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspeciallegendreMatrix::multiply(self : MathspeciallegendreMatrix, other : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if self.cols != other.rows { return math_special_legendre_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_legendre_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathspeciallegendreMatrix::trace(self : MathspeciallegendreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspeciallegendreMatrix::det(self : MathspeciallegendreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspeciallegendreMatrix::norm(self : MathspeciallegendreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspeciallegendreMatrix::to_string(self : MathspeciallegendreMatrix) -> String {
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

pub(all) struct MathspeciallegendreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_legendre_make_vector(comps : Array[Double]) -> MathspeciallegendreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_legendre_vector_zero(dim : Int) -> MathspeciallegendreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspeciallegendreVector::add(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallegendreVector::sub(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallegendreVector::scale(self : MathspeciallegendreVector, s : Double) -> MathspeciallegendreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspeciallegendreVector::dot(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspeciallegendreVector::norm(self : MathspeciallegendreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspeciallegendreVector::normalize(self : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallegendreVector::dist(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspeciallegendreVector::to_string(self : MathspeciallegendreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallegendreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_frame_make(size : Int) -> MathspeciallegendreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreFrame::len(self : MathspeciallegendreFrame) -> Int { self.size }

pub fn MathspeciallegendreFrame::get(self : MathspeciallegendreFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreFrame::set(self : MathspeciallegendreFrame, i : Int, v : Double) -> MathspeciallegendreFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreFrame::sum(self : MathspeciallegendreFrame) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreFrame::mean(self : MathspeciallegendreFrame) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreFrame::scale(self : MathspeciallegendreFrame, f : Double) -> MathspeciallegendreFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreFrame::add(self : MathspeciallegendreFrame, other : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreFrame::copy(self : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreFrame::fill(self : MathspeciallegendreFrame, v : Double) -> MathspeciallegendreFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreFrame::min(self : MathspeciallegendreFrame) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreFrame::max(self : MathspeciallegendreFrame) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreFrame::to_string(self : MathspeciallegendreFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_table_make(size : Int) -> MathspeciallegendreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreTable::len(self : MathspeciallegendreTable) -> Int { self.size }

pub fn MathspeciallegendreTable::get(self : MathspeciallegendreTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreTable::set(self : MathspeciallegendreTable, i : Int, v : Double) -> MathspeciallegendreTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreTable::sum(self : MathspeciallegendreTable) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreTable::mean(self : MathspeciallegendreTable) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreTable::scale(self : MathspeciallegendreTable, f : Double) -> MathspeciallegendreTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreTable::add(self : MathspeciallegendreTable, other : MathspeciallegendreTable) -> MathspeciallegendreTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreTable::copy(self : MathspeciallegendreTable) -> MathspeciallegendreTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreTable::fill(self : MathspeciallegendreTable, v : Double) -> MathspeciallegendreTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreTable::min(self : MathspeciallegendreTable) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreTable::max(self : MathspeciallegendreTable) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreTable::to_string(self : MathspeciallegendreTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_graphn_make(size : Int) -> MathspeciallegendreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreGraphN::len(self : MathspeciallegendreGraphN) -> Int { self.size }

pub fn MathspeciallegendreGraphN::get(self : MathspeciallegendreGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreGraphN::set(self : MathspeciallegendreGraphN, i : Int, v : Double) -> MathspeciallegendreGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreGraphN::sum(self : MathspeciallegendreGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreGraphN::mean(self : MathspeciallegendreGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreGraphN::scale(self : MathspeciallegendreGraphN, f : Double) -> MathspeciallegendreGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreGraphN::add(self : MathspeciallegendreGraphN, other : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreGraphN::copy(self : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreGraphN::fill(self : MathspeciallegendreGraphN, v : Double) -> MathspeciallegendreGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreGraphN::min(self : MathspeciallegendreGraphN) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreGraphN::max(self : MathspeciallegendreGraphN) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreGraphN::to_string(self : MathspeciallegendreGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_node_make(size : Int) -> MathspeciallegendreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreNode::len(self : MathspeciallegendreNode) -> Int { self.size }

pub fn MathspeciallegendreNode::get(self : MathspeciallegendreNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreNode::set(self : MathspeciallegendreNode, i : Int, v : Double) -> MathspeciallegendreNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreNode::sum(self : MathspeciallegendreNode) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreNode::mean(self : MathspeciallegendreNode) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreNode::scale(self : MathspeciallegendreNode, f : Double) -> MathspeciallegendreNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreNode::add(self : MathspeciallegendreNode, other : MathspeciallegendreNode) -> MathspeciallegendreNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreNode::copy(self : MathspeciallegendreNode) -> MathspeciallegendreNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreNode::fill(self : MathspeciallegendreNode, v : Double) -> MathspeciallegendreNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreNode::min(self : MathspeciallegendreNode) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreNode::max(self : MathspeciallegendreNode) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreNode::to_string(self : MathspeciallegendreNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_edge_make(size : Int) -> MathspeciallegendreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreEdge::len(self : MathspeciallegendreEdge) -> Int { self.size }

pub fn MathspeciallegendreEdge::get(self : MathspeciallegendreEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreEdge::set(self : MathspeciallegendreEdge, i : Int, v : Double) -> MathspeciallegendreEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreEdge::sum(self : MathspeciallegendreEdge) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreEdge::mean(self : MathspeciallegendreEdge) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreEdge::scale(self : MathspeciallegendreEdge, f : Double) -> MathspeciallegendreEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreEdge::add(self : MathspeciallegendreEdge, other : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreEdge::copy(self : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreEdge::fill(self : MathspeciallegendreEdge, v : Double) -> MathspeciallegendreEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreEdge::min(self : MathspeciallegendreEdge) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreEdge::max(self : MathspeciallegendreEdge) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreEdge::to_string(self : MathspeciallegendreEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_path_make(size : Int) -> MathspeciallegendrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendrePath::len(self : MathspeciallegendrePath) -> Int { self.size }

pub fn MathspeciallegendrePath::get(self : MathspeciallegendrePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendrePath::set(self : MathspeciallegendrePath, i : Int, v : Double) -> MathspeciallegendrePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendrePath::sum(self : MathspeciallegendrePath) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendrePath::mean(self : MathspeciallegendrePath) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendrePath::scale(self : MathspeciallegendrePath, f : Double) -> MathspeciallegendrePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendrePath::add(self : MathspeciallegendrePath, other : MathspeciallegendrePath) -> MathspeciallegendrePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendrePath::copy(self : MathspeciallegendrePath) -> MathspeciallegendrePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendrePath::fill(self : MathspeciallegendrePath, v : Double) -> MathspeciallegendrePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendrePath::min(self : MathspeciallegendrePath) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendrePath::max(self : MathspeciallegendrePath) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendrePath::to_string(self : MathspeciallegendrePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cluster_make(size : Int) -> MathspeciallegendreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreCluster::len(self : MathspeciallegendreCluster) -> Int { self.size }

pub fn MathspeciallegendreCluster::get(self : MathspeciallegendreCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreCluster::set(self : MathspeciallegendreCluster, i : Int, v : Double) -> MathspeciallegendreCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCluster::sum(self : MathspeciallegendreCluster) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreCluster::mean(self : MathspeciallegendreCluster) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreCluster::scale(self : MathspeciallegendreCluster, f : Double) -> MathspeciallegendreCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCluster::add(self : MathspeciallegendreCluster, other : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreCluster::copy(self : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCluster::fill(self : MathspeciallegendreCluster, v : Double) -> MathspeciallegendreCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCluster::min(self : MathspeciallegendreCluster) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreCluster::max(self : MathspeciallegendreCluster) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreCluster::to_string(self : MathspeciallegendreCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_model_make(size : Int) -> MathspeciallegendreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreModel::len(self : MathspeciallegendreModel) -> Int { self.size }

pub fn MathspeciallegendreModel::get(self : MathspeciallegendreModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreModel::set(self : MathspeciallegendreModel, i : Int, v : Double) -> MathspeciallegendreModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreModel::sum(self : MathspeciallegendreModel) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreModel::mean(self : MathspeciallegendreModel) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreModel::scale(self : MathspeciallegendreModel, f : Double) -> MathspeciallegendreModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreModel::add(self : MathspeciallegendreModel, other : MathspeciallegendreModel) -> MathspeciallegendreModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreModel::copy(self : MathspeciallegendreModel) -> MathspeciallegendreModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreModel::fill(self : MathspeciallegendreModel, v : Double) -> MathspeciallegendreModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreModel::min(self : MathspeciallegendreModel) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreModel::max(self : MathspeciallegendreModel) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreModel::to_string(self : MathspeciallegendreModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_layer_make(size : Int) -> MathspeciallegendreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreLayer::len(self : MathspeciallegendreLayer) -> Int { self.size }

pub fn MathspeciallegendreLayer::get(self : MathspeciallegendreLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreLayer::set(self : MathspeciallegendreLayer, i : Int, v : Double) -> MathspeciallegendreLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreLayer::sum(self : MathspeciallegendreLayer) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreLayer::mean(self : MathspeciallegendreLayer) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreLayer::scale(self : MathspeciallegendreLayer, f : Double) -> MathspeciallegendreLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreLayer::add(self : MathspeciallegendreLayer, other : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreLayer::copy(self : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreLayer::fill(self : MathspeciallegendreLayer, v : Double) -> MathspeciallegendreLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreLayer::min(self : MathspeciallegendreLayer) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreLayer::max(self : MathspeciallegendreLayer) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreLayer::to_string(self : MathspeciallegendreLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_buffer_make(size : Int) -> MathspeciallegendreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreBuffer::len(self : MathspeciallegendreBuffer) -> Int { self.size }

pub fn MathspeciallegendreBuffer::get(self : MathspeciallegendreBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreBuffer::set(self : MathspeciallegendreBuffer, i : Int, v : Double) -> MathspeciallegendreBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreBuffer::sum(self : MathspeciallegendreBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreBuffer::mean(self : MathspeciallegendreBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreBuffer::scale(self : MathspeciallegendreBuffer, f : Double) -> MathspeciallegendreBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreBuffer::add(self : MathspeciallegendreBuffer, other : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreBuffer::copy(self : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreBuffer::fill(self : MathspeciallegendreBuffer, v : Double) -> MathspeciallegendreBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreBuffer::min(self : MathspeciallegendreBuffer) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreBuffer::max(self : MathspeciallegendreBuffer) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreBuffer::to_string(self : MathspeciallegendreBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cursor_make(size : Int) -> MathspeciallegendreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreCursor::len(self : MathspeciallegendreCursor) -> Int { self.size }

pub fn MathspeciallegendreCursor::get(self : MathspeciallegendreCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreCursor::set(self : MathspeciallegendreCursor, i : Int, v : Double) -> MathspeciallegendreCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCursor::sum(self : MathspeciallegendreCursor) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreCursor::mean(self : MathspeciallegendreCursor) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreCursor::scale(self : MathspeciallegendreCursor, f : Double) -> MathspeciallegendreCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCursor::add(self : MathspeciallegendreCursor, other : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreCursor::copy(self : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCursor::fill(self : MathspeciallegendreCursor, v : Double) -> MathspeciallegendreCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreCursor::min(self : MathspeciallegendreCursor) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreCursor::max(self : MathspeciallegendreCursor) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreCursor::to_string(self : MathspeciallegendreCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_view_make(size : Int) -> MathspeciallegendreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreView::len(self : MathspeciallegendreView) -> Int { self.size }

pub fn MathspeciallegendreView::get(self : MathspeciallegendreView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreView::set(self : MathspeciallegendreView, i : Int, v : Double) -> MathspeciallegendreView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreView::sum(self : MathspeciallegendreView) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreView::mean(self : MathspeciallegendreView) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreView::scale(self : MathspeciallegendreView, f : Double) -> MathspeciallegendreView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreView::add(self : MathspeciallegendreView, other : MathspeciallegendreView) -> MathspeciallegendreView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreView::copy(self : MathspeciallegendreView) -> MathspeciallegendreView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreView::fill(self : MathspeciallegendreView, v : Double) -> MathspeciallegendreView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreView::min(self : MathspeciallegendreView) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreView::max(self : MathspeciallegendreView) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreView::to_string(self : MathspeciallegendreView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_range_make(size : Int) -> MathspeciallegendreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreRange::len(self : MathspeciallegendreRange) -> Int { self.size }

pub fn MathspeciallegendreRange::get(self : MathspeciallegendreRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreRange::set(self : MathspeciallegendreRange, i : Int, v : Double) -> MathspeciallegendreRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreRange::sum(self : MathspeciallegendreRange) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreRange::mean(self : MathspeciallegendreRange) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreRange::scale(self : MathspeciallegendreRange, f : Double) -> MathspeciallegendreRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreRange::add(self : MathspeciallegendreRange, other : MathspeciallegendreRange) -> MathspeciallegendreRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreRange::copy(self : MathspeciallegendreRange) -> MathspeciallegendreRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreRange::fill(self : MathspeciallegendreRange, v : Double) -> MathspeciallegendreRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreRange::min(self : MathspeciallegendreRange) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreRange::max(self : MathspeciallegendreRange) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreRange::to_string(self : MathspeciallegendreRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_slice_make(size : Int) -> MathspeciallegendreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspeciallegendreSlice::len(self : MathspeciallegendreSlice) -> Int { self.size }

pub fn MathspeciallegendreSlice::get(self : MathspeciallegendreSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspeciallegendreSlice::set(self : MathspeciallegendreSlice, i : Int, v : Double) -> MathspeciallegendreSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreSlice::sum(self : MathspeciallegendreSlice) -> Double { @_common.sum(self.data) }

pub fn MathspeciallegendreSlice::mean(self : MathspeciallegendreSlice) -> Double { @_common.mean(self.data) }

pub fn MathspeciallegendreSlice::scale(self : MathspeciallegendreSlice, f : Double) -> MathspeciallegendreSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreSlice::add(self : MathspeciallegendreSlice, other : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspeciallegendreSlice::copy(self : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreSlice::fill(self : MathspeciallegendreSlice, v : Double) -> MathspeciallegendreSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspeciallegendreSlice::min(self : MathspeciallegendreSlice) -> Double { @_common.min(self.data) }

pub fn MathspeciallegendreSlice::max(self : MathspeciallegendreSlice) -> Double { @_common.max(self.data) }

pub fn MathspeciallegendreSlice::to_string(self : MathspeciallegendreSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

