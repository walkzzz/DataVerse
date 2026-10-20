///===
/// extcore/image_morph_gradient

pub(all) struct ImagemorphgradientPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_gradient_make_point(x : Double, y : Double) -> ImagemorphgradientPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_gradient_make_point3(x : Double, y : Double, z : Double) -> ImagemorphgradientPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphgradientPoint::x(self : ImagemorphgradientPoint) -> Double { self.x }

pub fn ImagemorphgradientPoint::y(self : ImagemorphgradientPoint) -> Double { self.y }

pub fn ImagemorphgradientPoint::z(self : ImagemorphgradientPoint) -> Double { self.z }

pub fn ImagemorphgradientPoint::label(self : ImagemorphgradientPoint) -> Int { self.label }

pub fn ImagemorphgradientPoint::dist(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphgradientPoint::add(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphgradientPoint::sub(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphgradientPoint::scale(self : ImagemorphgradientPoint, s : Double) -> ImagemorphgradientPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphgradientPoint::dot(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphgradientPoint::cross(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphgradientPoint::norm(self : ImagemorphgradientPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphgradientPoint::normalize(self : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphgradientPoint::negate(self : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphgradientPoint::mid(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphgradientPoint::lerp(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint, t : Double) -> ImagemorphgradientPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphgradientPoint::to_string(self : ImagemorphgradientPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphgradientSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_gradient_make_series(vals : Array[Double], name : String) -> ImagemorphgradientSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphgradientSeries::len(self : ImagemorphgradientSeries) -> Int { self.vals.length() }

pub fn ImagemorphgradientSeries::sum(self : ImagemorphgradientSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphgradientSeries::mean(self : ImagemorphgradientSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphgradientSeries::min(self : ImagemorphgradientSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphgradientSeries::max(self : ImagemorphgradientSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphgradientSeries::range(self : ImagemorphgradientSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphgradientSeries::variance(self : ImagemorphgradientSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphgradientSeries::std(self : ImagemorphgradientSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphgradientSeries::median(self : ImagemorphgradientSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphgradientSeries::scale(self : ImagemorphgradientSeries, f : Double) -> ImagemorphgradientSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::add(self : ImagemorphgradientSeries, other : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::sub(self : ImagemorphgradientSeries, other : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::normalize(self : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphgradientSeries::cumsum(self : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphgradientSeries::to_string(self : ImagemorphgradientSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphgradientMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_gradient_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphgradientMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_gradient_matrix_identity(n : Int) -> ImagemorphgradientMatrix {
  let m = image_morph_gradient_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphgradientMatrix::get(self : ImagemorphgradientMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphgradientMatrix::transpose(self : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphgradientMatrix::add(self : ImagemorphgradientMatrix, other : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_gradient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphgradientMatrix::scale(self : ImagemorphgradientMatrix, s : Double) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphgradientMatrix::multiply(self : ImagemorphgradientMatrix, other : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if self.cols != other.rows { return image_morph_gradient_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_gradient_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagemorphgradientMatrix::trace(self : ImagemorphgradientMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphgradientMatrix::det(self : ImagemorphgradientMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphgradientMatrix::norm(self : ImagemorphgradientMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphgradientMatrix::to_string(self : ImagemorphgradientMatrix) -> String {
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

pub(all) struct ImagemorphgradientVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_gradient_make_vector(comps : Array[Double]) -> ImagemorphgradientVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_gradient_vector_zero(dim : Int) -> ImagemorphgradientVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphgradientVector::add(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphgradientVector::sub(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphgradientVector::scale(self : ImagemorphgradientVector, s : Double) -> ImagemorphgradientVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphgradientVector::dot(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphgradientVector::norm(self : ImagemorphgradientVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphgradientVector::normalize(self : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphgradientVector::dist(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphgradientVector::to_string(self : ImagemorphgradientVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphgradientFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_frame_make(size : Int) -> ImagemorphgradientFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientFrame::len(self : ImagemorphgradientFrame) -> Int { self.size }

pub fn ImagemorphgradientFrame::get(self : ImagemorphgradientFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientFrame::set(self : ImagemorphgradientFrame, i : Int, v : Double) -> ImagemorphgradientFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientFrame::sum(self : ImagemorphgradientFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientFrame::mean(self : ImagemorphgradientFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientFrame::scale(self : ImagemorphgradientFrame, f : Double) -> ImagemorphgradientFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientFrame::add(self : ImagemorphgradientFrame, other : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientFrame::copy(self : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientFrame::fill(self : ImagemorphgradientFrame, v : Double) -> ImagemorphgradientFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientFrame::min(self : ImagemorphgradientFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientFrame::max(self : ImagemorphgradientFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientFrame::to_string(self : ImagemorphgradientFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_table_make(size : Int) -> ImagemorphgradientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientTable::len(self : ImagemorphgradientTable) -> Int { self.size }

pub fn ImagemorphgradientTable::get(self : ImagemorphgradientTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientTable::set(self : ImagemorphgradientTable, i : Int, v : Double) -> ImagemorphgradientTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientTable::sum(self : ImagemorphgradientTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientTable::mean(self : ImagemorphgradientTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientTable::scale(self : ImagemorphgradientTable, f : Double) -> ImagemorphgradientTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientTable::add(self : ImagemorphgradientTable, other : ImagemorphgradientTable) -> ImagemorphgradientTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientTable::copy(self : ImagemorphgradientTable) -> ImagemorphgradientTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientTable::fill(self : ImagemorphgradientTable, v : Double) -> ImagemorphgradientTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientTable::min(self : ImagemorphgradientTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientTable::max(self : ImagemorphgradientTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientTable::to_string(self : ImagemorphgradientTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_graphn_make(size : Int) -> ImagemorphgradientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientGraphN::len(self : ImagemorphgradientGraphN) -> Int { self.size }

pub fn ImagemorphgradientGraphN::get(self : ImagemorphgradientGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientGraphN::set(self : ImagemorphgradientGraphN, i : Int, v : Double) -> ImagemorphgradientGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientGraphN::sum(self : ImagemorphgradientGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientGraphN::mean(self : ImagemorphgradientGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientGraphN::scale(self : ImagemorphgradientGraphN, f : Double) -> ImagemorphgradientGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientGraphN::add(self : ImagemorphgradientGraphN, other : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientGraphN::copy(self : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientGraphN::fill(self : ImagemorphgradientGraphN, v : Double) -> ImagemorphgradientGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientGraphN::min(self : ImagemorphgradientGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientGraphN::max(self : ImagemorphgradientGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientGraphN::to_string(self : ImagemorphgradientGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_node_make(size : Int) -> ImagemorphgradientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientNode::len(self : ImagemorphgradientNode) -> Int { self.size }

pub fn ImagemorphgradientNode::get(self : ImagemorphgradientNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientNode::set(self : ImagemorphgradientNode, i : Int, v : Double) -> ImagemorphgradientNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientNode::sum(self : ImagemorphgradientNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientNode::mean(self : ImagemorphgradientNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientNode::scale(self : ImagemorphgradientNode, f : Double) -> ImagemorphgradientNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientNode::add(self : ImagemorphgradientNode, other : ImagemorphgradientNode) -> ImagemorphgradientNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientNode::copy(self : ImagemorphgradientNode) -> ImagemorphgradientNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientNode::fill(self : ImagemorphgradientNode, v : Double) -> ImagemorphgradientNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientNode::min(self : ImagemorphgradientNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientNode::max(self : ImagemorphgradientNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientNode::to_string(self : ImagemorphgradientNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_edge_make(size : Int) -> ImagemorphgradientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientEdge::len(self : ImagemorphgradientEdge) -> Int { self.size }

pub fn ImagemorphgradientEdge::get(self : ImagemorphgradientEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientEdge::set(self : ImagemorphgradientEdge, i : Int, v : Double) -> ImagemorphgradientEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientEdge::sum(self : ImagemorphgradientEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientEdge::mean(self : ImagemorphgradientEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientEdge::scale(self : ImagemorphgradientEdge, f : Double) -> ImagemorphgradientEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientEdge::add(self : ImagemorphgradientEdge, other : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientEdge::copy(self : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientEdge::fill(self : ImagemorphgradientEdge, v : Double) -> ImagemorphgradientEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientEdge::min(self : ImagemorphgradientEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientEdge::max(self : ImagemorphgradientEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientEdge::to_string(self : ImagemorphgradientEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_path_make(size : Int) -> ImagemorphgradientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientPath::len(self : ImagemorphgradientPath) -> Int { self.size }

pub fn ImagemorphgradientPath::get(self : ImagemorphgradientPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientPath::set(self : ImagemorphgradientPath, i : Int, v : Double) -> ImagemorphgradientPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientPath::sum(self : ImagemorphgradientPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientPath::mean(self : ImagemorphgradientPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientPath::scale(self : ImagemorphgradientPath, f : Double) -> ImagemorphgradientPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientPath::add(self : ImagemorphgradientPath, other : ImagemorphgradientPath) -> ImagemorphgradientPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientPath::copy(self : ImagemorphgradientPath) -> ImagemorphgradientPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientPath::fill(self : ImagemorphgradientPath, v : Double) -> ImagemorphgradientPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientPath::min(self : ImagemorphgradientPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientPath::max(self : ImagemorphgradientPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientPath::to_string(self : ImagemorphgradientPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cluster_make(size : Int) -> ImagemorphgradientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientCluster::len(self : ImagemorphgradientCluster) -> Int { self.size }

pub fn ImagemorphgradientCluster::get(self : ImagemorphgradientCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientCluster::set(self : ImagemorphgradientCluster, i : Int, v : Double) -> ImagemorphgradientCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCluster::sum(self : ImagemorphgradientCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientCluster::mean(self : ImagemorphgradientCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientCluster::scale(self : ImagemorphgradientCluster, f : Double) -> ImagemorphgradientCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCluster::add(self : ImagemorphgradientCluster, other : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientCluster::copy(self : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCluster::fill(self : ImagemorphgradientCluster, v : Double) -> ImagemorphgradientCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCluster::min(self : ImagemorphgradientCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientCluster::max(self : ImagemorphgradientCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientCluster::to_string(self : ImagemorphgradientCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_model_make(size : Int) -> ImagemorphgradientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientModel::len(self : ImagemorphgradientModel) -> Int { self.size }

pub fn ImagemorphgradientModel::get(self : ImagemorphgradientModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientModel::set(self : ImagemorphgradientModel, i : Int, v : Double) -> ImagemorphgradientModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientModel::sum(self : ImagemorphgradientModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientModel::mean(self : ImagemorphgradientModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientModel::scale(self : ImagemorphgradientModel, f : Double) -> ImagemorphgradientModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientModel::add(self : ImagemorphgradientModel, other : ImagemorphgradientModel) -> ImagemorphgradientModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientModel::copy(self : ImagemorphgradientModel) -> ImagemorphgradientModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientModel::fill(self : ImagemorphgradientModel, v : Double) -> ImagemorphgradientModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientModel::min(self : ImagemorphgradientModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientModel::max(self : ImagemorphgradientModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientModel::to_string(self : ImagemorphgradientModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_layer_make(size : Int) -> ImagemorphgradientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientLayer::len(self : ImagemorphgradientLayer) -> Int { self.size }

pub fn ImagemorphgradientLayer::get(self : ImagemorphgradientLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientLayer::set(self : ImagemorphgradientLayer, i : Int, v : Double) -> ImagemorphgradientLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientLayer::sum(self : ImagemorphgradientLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientLayer::mean(self : ImagemorphgradientLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientLayer::scale(self : ImagemorphgradientLayer, f : Double) -> ImagemorphgradientLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientLayer::add(self : ImagemorphgradientLayer, other : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientLayer::copy(self : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientLayer::fill(self : ImagemorphgradientLayer, v : Double) -> ImagemorphgradientLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientLayer::min(self : ImagemorphgradientLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientLayer::max(self : ImagemorphgradientLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientLayer::to_string(self : ImagemorphgradientLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_buffer_make(size : Int) -> ImagemorphgradientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientBuffer::len(self : ImagemorphgradientBuffer) -> Int { self.size }

pub fn ImagemorphgradientBuffer::get(self : ImagemorphgradientBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientBuffer::set(self : ImagemorphgradientBuffer, i : Int, v : Double) -> ImagemorphgradientBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientBuffer::sum(self : ImagemorphgradientBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientBuffer::mean(self : ImagemorphgradientBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientBuffer::scale(self : ImagemorphgradientBuffer, f : Double) -> ImagemorphgradientBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientBuffer::add(self : ImagemorphgradientBuffer, other : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientBuffer::copy(self : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientBuffer::fill(self : ImagemorphgradientBuffer, v : Double) -> ImagemorphgradientBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientBuffer::min(self : ImagemorphgradientBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientBuffer::max(self : ImagemorphgradientBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientBuffer::to_string(self : ImagemorphgradientBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cursor_make(size : Int) -> ImagemorphgradientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientCursor::len(self : ImagemorphgradientCursor) -> Int { self.size }

pub fn ImagemorphgradientCursor::get(self : ImagemorphgradientCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientCursor::set(self : ImagemorphgradientCursor, i : Int, v : Double) -> ImagemorphgradientCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCursor::sum(self : ImagemorphgradientCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientCursor::mean(self : ImagemorphgradientCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientCursor::scale(self : ImagemorphgradientCursor, f : Double) -> ImagemorphgradientCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCursor::add(self : ImagemorphgradientCursor, other : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientCursor::copy(self : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCursor::fill(self : ImagemorphgradientCursor, v : Double) -> ImagemorphgradientCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientCursor::min(self : ImagemorphgradientCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientCursor::max(self : ImagemorphgradientCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientCursor::to_string(self : ImagemorphgradientCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_view_make(size : Int) -> ImagemorphgradientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientView::len(self : ImagemorphgradientView) -> Int { self.size }

pub fn ImagemorphgradientView::get(self : ImagemorphgradientView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientView::set(self : ImagemorphgradientView, i : Int, v : Double) -> ImagemorphgradientView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientView::sum(self : ImagemorphgradientView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientView::mean(self : ImagemorphgradientView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientView::scale(self : ImagemorphgradientView, f : Double) -> ImagemorphgradientView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientView::add(self : ImagemorphgradientView, other : ImagemorphgradientView) -> ImagemorphgradientView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientView::copy(self : ImagemorphgradientView) -> ImagemorphgradientView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientView::fill(self : ImagemorphgradientView, v : Double) -> ImagemorphgradientView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientView::min(self : ImagemorphgradientView) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientView::max(self : ImagemorphgradientView) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientView::to_string(self : ImagemorphgradientView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_range_make(size : Int) -> ImagemorphgradientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientRange::len(self : ImagemorphgradientRange) -> Int { self.size }

pub fn ImagemorphgradientRange::get(self : ImagemorphgradientRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientRange::set(self : ImagemorphgradientRange, i : Int, v : Double) -> ImagemorphgradientRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientRange::sum(self : ImagemorphgradientRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientRange::mean(self : ImagemorphgradientRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientRange::scale(self : ImagemorphgradientRange, f : Double) -> ImagemorphgradientRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientRange::add(self : ImagemorphgradientRange, other : ImagemorphgradientRange) -> ImagemorphgradientRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientRange::copy(self : ImagemorphgradientRange) -> ImagemorphgradientRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientRange::fill(self : ImagemorphgradientRange, v : Double) -> ImagemorphgradientRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientRange::min(self : ImagemorphgradientRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientRange::max(self : ImagemorphgradientRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientRange::to_string(self : ImagemorphgradientRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_slice_make(size : Int) -> ImagemorphgradientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphgradientSlice::len(self : ImagemorphgradientSlice) -> Int { self.size }

pub fn ImagemorphgradientSlice::get(self : ImagemorphgradientSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphgradientSlice::set(self : ImagemorphgradientSlice, i : Int, v : Double) -> ImagemorphgradientSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientSlice::sum(self : ImagemorphgradientSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphgradientSlice::mean(self : ImagemorphgradientSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphgradientSlice::scale(self : ImagemorphgradientSlice, f : Double) -> ImagemorphgradientSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientSlice::add(self : ImagemorphgradientSlice, other : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphgradientSlice::copy(self : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientSlice::fill(self : ImagemorphgradientSlice, v : Double) -> ImagemorphgradientSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphgradientSlice::min(self : ImagemorphgradientSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphgradientSlice::max(self : ImagemorphgradientSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphgradientSlice::to_string(self : ImagemorphgradientSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

