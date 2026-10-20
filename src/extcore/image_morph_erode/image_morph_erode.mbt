///===
/// extcore/image_morph_erode

pub(all) struct ImagemorpherodePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_erode_make_point(x : Double, y : Double) -> ImagemorpherodePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_erode_make_point3(x : Double, y : Double, z : Double) -> ImagemorpherodePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorpherodePoint::x(self : ImagemorpherodePoint) -> Double { self.x }

pub fn ImagemorpherodePoint::y(self : ImagemorpherodePoint) -> Double { self.y }

pub fn ImagemorpherodePoint::z(self : ImagemorpherodePoint) -> Double { self.z }

pub fn ImagemorpherodePoint::label(self : ImagemorpherodePoint) -> Int { self.label }

pub fn ImagemorpherodePoint::dist(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorpherodePoint::add(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorpherodePoint::sub(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorpherodePoint::scale(self : ImagemorpherodePoint, s : Double) -> ImagemorpherodePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorpherodePoint::dot(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorpherodePoint::cross(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorpherodePoint::norm(self : ImagemorpherodePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorpherodePoint::normalize(self : ImagemorpherodePoint) -> ImagemorpherodePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorpherodePoint::negate(self : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorpherodePoint::mid(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorpherodePoint::lerp(self : ImagemorpherodePoint, other : ImagemorpherodePoint, t : Double) -> ImagemorpherodePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorpherodePoint::to_string(self : ImagemorpherodePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorpherodeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_erode_make_series(vals : Array[Double], name : String) -> ImagemorpherodeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorpherodeSeries::len(self : ImagemorpherodeSeries) -> Int { self.vals.length() }

pub fn ImagemorpherodeSeries::sum(self : ImagemorpherodeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorpherodeSeries::mean(self : ImagemorpherodeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorpherodeSeries::min(self : ImagemorpherodeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorpherodeSeries::max(self : ImagemorpherodeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorpherodeSeries::range(self : ImagemorpherodeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorpherodeSeries::variance(self : ImagemorpherodeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorpherodeSeries::std(self : ImagemorpherodeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorpherodeSeries::median(self : ImagemorpherodeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorpherodeSeries::scale(self : ImagemorpherodeSeries, f : Double) -> ImagemorpherodeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::add(self : ImagemorpherodeSeries, other : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::sub(self : ImagemorpherodeSeries, other : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::normalize(self : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorpherodeSeries::cumsum(self : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorpherodeSeries::to_string(self : ImagemorpherodeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorpherodeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_erode_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorpherodeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_erode_matrix_identity(n : Int) -> ImagemorpherodeMatrix {
  let m = image_morph_erode_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorpherodeMatrix::get(self : ImagemorpherodeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorpherodeMatrix::transpose(self : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorpherodeMatrix::add(self : ImagemorpherodeMatrix, other : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_erode_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorpherodeMatrix::scale(self : ImagemorpherodeMatrix, s : Double) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorpherodeMatrix::multiply(self : ImagemorpherodeMatrix, other : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if self.cols != other.rows { return image_morph_erode_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_erode_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorpherodeMatrix::trace(self : ImagemorpherodeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorpherodeMatrix::det(self : ImagemorpherodeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorpherodeMatrix::norm(self : ImagemorpherodeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorpherodeMatrix::to_string(self : ImagemorpherodeMatrix) -> String {
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

pub(all) struct ImagemorpherodeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_erode_make_vector(comps : Array[Double]) -> ImagemorpherodeVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_erode_vector_zero(dim : Int) -> ImagemorpherodeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorpherodeVector::add(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorpherodeVector::sub(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorpherodeVector::scale(self : ImagemorpherodeVector, s : Double) -> ImagemorpherodeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorpherodeVector::dot(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorpherodeVector::norm(self : ImagemorpherodeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorpherodeVector::normalize(self : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorpherodeVector::dist(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorpherodeVector::to_string(self : ImagemorpherodeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorpherodeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_frame_make(size : Int) -> ImagemorpherodeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeFrame::len(self : ImagemorpherodeFrame) -> Int { self.size }

pub fn ImagemorpherodeFrame::get(self : ImagemorpherodeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeFrame::set(self : ImagemorpherodeFrame, i : Int, v : Double) -> ImagemorpherodeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeFrame::sum(self : ImagemorpherodeFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeFrame::mean(self : ImagemorpherodeFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeFrame::scale(self : ImagemorpherodeFrame, f : Double) -> ImagemorpherodeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeFrame::add(self : ImagemorpherodeFrame, other : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeFrame::copy(self : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeFrame::fill(self : ImagemorpherodeFrame, v : Double) -> ImagemorpherodeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeFrame::min(self : ImagemorpherodeFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeFrame::max(self : ImagemorpherodeFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeFrame::to_string(self : ImagemorpherodeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_table_make(size : Int) -> ImagemorpherodeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeTable::len(self : ImagemorpherodeTable) -> Int { self.size }

pub fn ImagemorpherodeTable::get(self : ImagemorpherodeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeTable::set(self : ImagemorpherodeTable, i : Int, v : Double) -> ImagemorpherodeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeTable::sum(self : ImagemorpherodeTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeTable::mean(self : ImagemorpherodeTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeTable::scale(self : ImagemorpherodeTable, f : Double) -> ImagemorpherodeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeTable::add(self : ImagemorpherodeTable, other : ImagemorpherodeTable) -> ImagemorpherodeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeTable::copy(self : ImagemorpherodeTable) -> ImagemorpherodeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeTable::fill(self : ImagemorpherodeTable, v : Double) -> ImagemorpherodeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeTable::min(self : ImagemorpherodeTable) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeTable::max(self : ImagemorpherodeTable) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeTable::to_string(self : ImagemorpherodeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_graphn_make(size : Int) -> ImagemorpherodeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeGraphN::len(self : ImagemorpherodeGraphN) -> Int { self.size }

pub fn ImagemorpherodeGraphN::get(self : ImagemorpherodeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeGraphN::set(self : ImagemorpherodeGraphN, i : Int, v : Double) -> ImagemorpherodeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeGraphN::sum(self : ImagemorpherodeGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeGraphN::mean(self : ImagemorpherodeGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeGraphN::scale(self : ImagemorpherodeGraphN, f : Double) -> ImagemorpherodeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeGraphN::add(self : ImagemorpherodeGraphN, other : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeGraphN::copy(self : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeGraphN::fill(self : ImagemorpherodeGraphN, v : Double) -> ImagemorpherodeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeGraphN::min(self : ImagemorpherodeGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeGraphN::max(self : ImagemorpherodeGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeGraphN::to_string(self : ImagemorpherodeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_node_make(size : Int) -> ImagemorpherodeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeNode::len(self : ImagemorpherodeNode) -> Int { self.size }

pub fn ImagemorpherodeNode::get(self : ImagemorpherodeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeNode::set(self : ImagemorpherodeNode, i : Int, v : Double) -> ImagemorpherodeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeNode::sum(self : ImagemorpherodeNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeNode::mean(self : ImagemorpherodeNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeNode::scale(self : ImagemorpherodeNode, f : Double) -> ImagemorpherodeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeNode::add(self : ImagemorpherodeNode, other : ImagemorpherodeNode) -> ImagemorpherodeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeNode::copy(self : ImagemorpherodeNode) -> ImagemorpherodeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeNode::fill(self : ImagemorpherodeNode, v : Double) -> ImagemorpherodeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeNode::min(self : ImagemorpherodeNode) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeNode::max(self : ImagemorpherodeNode) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeNode::to_string(self : ImagemorpherodeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_edge_make(size : Int) -> ImagemorpherodeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeEdge::len(self : ImagemorpherodeEdge) -> Int { self.size }

pub fn ImagemorpherodeEdge::get(self : ImagemorpherodeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeEdge::set(self : ImagemorpherodeEdge, i : Int, v : Double) -> ImagemorpherodeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeEdge::sum(self : ImagemorpherodeEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeEdge::mean(self : ImagemorpherodeEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeEdge::scale(self : ImagemorpherodeEdge, f : Double) -> ImagemorpherodeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeEdge::add(self : ImagemorpherodeEdge, other : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeEdge::copy(self : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeEdge::fill(self : ImagemorpherodeEdge, v : Double) -> ImagemorpherodeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeEdge::min(self : ImagemorpherodeEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeEdge::max(self : ImagemorpherodeEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeEdge::to_string(self : ImagemorpherodeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_path_make(size : Int) -> ImagemorpherodePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodePath::len(self : ImagemorpherodePath) -> Int { self.size }

pub fn ImagemorpherodePath::get(self : ImagemorpherodePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodePath::set(self : ImagemorpherodePath, i : Int, v : Double) -> ImagemorpherodePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodePath::sum(self : ImagemorpherodePath) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodePath::mean(self : ImagemorpherodePath) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodePath::scale(self : ImagemorpherodePath, f : Double) -> ImagemorpherodePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodePath::add(self : ImagemorpherodePath, other : ImagemorpherodePath) -> ImagemorpherodePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodePath::copy(self : ImagemorpherodePath) -> ImagemorpherodePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodePath::fill(self : ImagemorpherodePath, v : Double) -> ImagemorpherodePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodePath::min(self : ImagemorpherodePath) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodePath::max(self : ImagemorpherodePath) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodePath::to_string(self : ImagemorpherodePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cluster_make(size : Int) -> ImagemorpherodeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeCluster::len(self : ImagemorpherodeCluster) -> Int { self.size }

pub fn ImagemorpherodeCluster::get(self : ImagemorpherodeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeCluster::set(self : ImagemorpherodeCluster, i : Int, v : Double) -> ImagemorpherodeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCluster::sum(self : ImagemorpherodeCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeCluster::mean(self : ImagemorpherodeCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeCluster::scale(self : ImagemorpherodeCluster, f : Double) -> ImagemorpherodeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCluster::add(self : ImagemorpherodeCluster, other : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeCluster::copy(self : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCluster::fill(self : ImagemorpherodeCluster, v : Double) -> ImagemorpherodeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCluster::min(self : ImagemorpherodeCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeCluster::max(self : ImagemorpherodeCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeCluster::to_string(self : ImagemorpherodeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_model_make(size : Int) -> ImagemorpherodeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeModel::len(self : ImagemorpherodeModel) -> Int { self.size }

pub fn ImagemorpherodeModel::get(self : ImagemorpherodeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeModel::set(self : ImagemorpherodeModel, i : Int, v : Double) -> ImagemorpherodeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeModel::sum(self : ImagemorpherodeModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeModel::mean(self : ImagemorpherodeModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeModel::scale(self : ImagemorpherodeModel, f : Double) -> ImagemorpherodeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeModel::add(self : ImagemorpherodeModel, other : ImagemorpherodeModel) -> ImagemorpherodeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeModel::copy(self : ImagemorpherodeModel) -> ImagemorpherodeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeModel::fill(self : ImagemorpherodeModel, v : Double) -> ImagemorpherodeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeModel::min(self : ImagemorpherodeModel) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeModel::max(self : ImagemorpherodeModel) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeModel::to_string(self : ImagemorpherodeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_layer_make(size : Int) -> ImagemorpherodeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeLayer::len(self : ImagemorpherodeLayer) -> Int { self.size }

pub fn ImagemorpherodeLayer::get(self : ImagemorpherodeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeLayer::set(self : ImagemorpherodeLayer, i : Int, v : Double) -> ImagemorpherodeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeLayer::sum(self : ImagemorpherodeLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeLayer::mean(self : ImagemorpherodeLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeLayer::scale(self : ImagemorpherodeLayer, f : Double) -> ImagemorpherodeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeLayer::add(self : ImagemorpherodeLayer, other : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeLayer::copy(self : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeLayer::fill(self : ImagemorpherodeLayer, v : Double) -> ImagemorpherodeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeLayer::min(self : ImagemorpherodeLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeLayer::max(self : ImagemorpherodeLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeLayer::to_string(self : ImagemorpherodeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_buffer_make(size : Int) -> ImagemorpherodeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeBuffer::len(self : ImagemorpherodeBuffer) -> Int { self.size }

pub fn ImagemorpherodeBuffer::get(self : ImagemorpherodeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeBuffer::set(self : ImagemorpherodeBuffer, i : Int, v : Double) -> ImagemorpherodeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeBuffer::sum(self : ImagemorpherodeBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeBuffer::mean(self : ImagemorpherodeBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeBuffer::scale(self : ImagemorpherodeBuffer, f : Double) -> ImagemorpherodeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeBuffer::add(self : ImagemorpherodeBuffer, other : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeBuffer::copy(self : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeBuffer::fill(self : ImagemorpherodeBuffer, v : Double) -> ImagemorpherodeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeBuffer::min(self : ImagemorpherodeBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeBuffer::max(self : ImagemorpherodeBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeBuffer::to_string(self : ImagemorpherodeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cursor_make(size : Int) -> ImagemorpherodeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeCursor::len(self : ImagemorpherodeCursor) -> Int { self.size }

pub fn ImagemorpherodeCursor::get(self : ImagemorpherodeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeCursor::set(self : ImagemorpherodeCursor, i : Int, v : Double) -> ImagemorpherodeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCursor::sum(self : ImagemorpherodeCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeCursor::mean(self : ImagemorpherodeCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeCursor::scale(self : ImagemorpherodeCursor, f : Double) -> ImagemorpherodeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCursor::add(self : ImagemorpherodeCursor, other : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeCursor::copy(self : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCursor::fill(self : ImagemorpherodeCursor, v : Double) -> ImagemorpherodeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeCursor::min(self : ImagemorpherodeCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeCursor::max(self : ImagemorpherodeCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeCursor::to_string(self : ImagemorpherodeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_view_make(size : Int) -> ImagemorpherodeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeView::len(self : ImagemorpherodeView) -> Int { self.size }

pub fn ImagemorpherodeView::get(self : ImagemorpherodeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeView::set(self : ImagemorpherodeView, i : Int, v : Double) -> ImagemorpherodeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeView::sum(self : ImagemorpherodeView) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeView::mean(self : ImagemorpherodeView) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeView::scale(self : ImagemorpherodeView, f : Double) -> ImagemorpherodeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeView::add(self : ImagemorpherodeView, other : ImagemorpherodeView) -> ImagemorpherodeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeView::copy(self : ImagemorpherodeView) -> ImagemorpherodeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeView::fill(self : ImagemorpherodeView, v : Double) -> ImagemorpherodeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeView::min(self : ImagemorpherodeView) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeView::max(self : ImagemorpherodeView) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeView::to_string(self : ImagemorpherodeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_range_make(size : Int) -> ImagemorpherodeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeRange::len(self : ImagemorpherodeRange) -> Int { self.size }

pub fn ImagemorpherodeRange::get(self : ImagemorpherodeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeRange::set(self : ImagemorpherodeRange, i : Int, v : Double) -> ImagemorpherodeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeRange::sum(self : ImagemorpherodeRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeRange::mean(self : ImagemorpherodeRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeRange::scale(self : ImagemorpherodeRange, f : Double) -> ImagemorpherodeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeRange::add(self : ImagemorpherodeRange, other : ImagemorpherodeRange) -> ImagemorpherodeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeRange::copy(self : ImagemorpherodeRange) -> ImagemorpherodeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeRange::fill(self : ImagemorpherodeRange, v : Double) -> ImagemorpherodeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeRange::min(self : ImagemorpherodeRange) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeRange::max(self : ImagemorpherodeRange) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeRange::to_string(self : ImagemorpherodeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_slice_make(size : Int) -> ImagemorpherodeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorpherodeSlice::len(self : ImagemorpherodeSlice) -> Int { self.size }

pub fn ImagemorpherodeSlice::get(self : ImagemorpherodeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorpherodeSlice::set(self : ImagemorpherodeSlice, i : Int, v : Double) -> ImagemorpherodeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeSlice::sum(self : ImagemorpherodeSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorpherodeSlice::mean(self : ImagemorpherodeSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorpherodeSlice::scale(self : ImagemorpherodeSlice, f : Double) -> ImagemorpherodeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeSlice::add(self : ImagemorpherodeSlice, other : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorpherodeSlice::copy(self : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeSlice::fill(self : ImagemorpherodeSlice, v : Double) -> ImagemorpherodeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorpherodeSlice::min(self : ImagemorpherodeSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorpherodeSlice::max(self : ImagemorpherodeSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorpherodeSlice::to_string(self : ImagemorpherodeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

