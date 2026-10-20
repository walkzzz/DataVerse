///===
/// extcore/image_transform_perspective

pub(all) struct ImagetransformperspectivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_perspective_make_point(x : Double, y : Double) -> ImagetransformperspectivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_perspective_make_point3(x : Double, y : Double, z : Double) -> ImagetransformperspectivePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformperspectivePoint::x(self : ImagetransformperspectivePoint) -> Double { self.x }

pub fn ImagetransformperspectivePoint::y(self : ImagetransformperspectivePoint) -> Double { self.y }

pub fn ImagetransformperspectivePoint::z(self : ImagetransformperspectivePoint) -> Double { self.z }

pub fn ImagetransformperspectivePoint::label(self : ImagetransformperspectivePoint) -> Int { self.label }

pub fn ImagetransformperspectivePoint::dist(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformperspectivePoint::add(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::sub(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::scale(self : ImagetransformperspectivePoint, s : Double) -> ImagetransformperspectivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformperspectivePoint::dot(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformperspectivePoint::cross(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformperspectivePoint::norm(self : ImagetransformperspectivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformperspectivePoint::normalize(self : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformperspectivePoint::negate(self : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::mid(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformperspectivePoint::lerp(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint, t : Double) -> ImagetransformperspectivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformperspectivePoint::to_string(self : ImagetransformperspectivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_perspective_make_series(vals : Array[Double], name : String) -> ImagetransformperspectiveSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformperspectiveSeries::len(self : ImagetransformperspectiveSeries) -> Int { self.vals.length() }

pub fn ImagetransformperspectiveSeries::sum(self : ImagetransformperspectiveSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformperspectiveSeries::mean(self : ImagetransformperspectiveSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformperspectiveSeries::min(self : ImagetransformperspectiveSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformperspectiveSeries::max(self : ImagetransformperspectiveSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformperspectiveSeries::range(self : ImagetransformperspectiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformperspectiveSeries::variance(self : ImagetransformperspectiveSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformperspectiveSeries::std(self : ImagetransformperspectiveSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformperspectiveSeries::median(self : ImagetransformperspectiveSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformperspectiveSeries::scale(self : ImagetransformperspectiveSeries, f : Double) -> ImagetransformperspectiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::add(self : ImagetransformperspectiveSeries, other : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::sub(self : ImagetransformperspectiveSeries, other : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::normalize(self : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformperspectiveSeries::cumsum(self : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::to_string(self : ImagetransformperspectiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformperspectiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_perspective_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformperspectiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_perspective_matrix_identity(n : Int) -> ImagetransformperspectiveMatrix {
  let m = image_transform_perspective_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformperspectiveMatrix::get(self : ImagetransformperspectiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformperspectiveMatrix::transpose(self : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformperspectiveMatrix::add(self : ImagetransformperspectiveMatrix, other : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_perspective_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformperspectiveMatrix::scale(self : ImagetransformperspectiveMatrix, s : Double) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformperspectiveMatrix::multiply(self : ImagetransformperspectiveMatrix, other : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if self.cols != other.rows { return image_transform_perspective_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_perspective_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformperspectiveMatrix::trace(self : ImagetransformperspectiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformperspectiveMatrix::det(self : ImagetransformperspectiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformperspectiveMatrix::norm(self : ImagetransformperspectiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformperspectiveMatrix::to_string(self : ImagetransformperspectiveMatrix) -> String {
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

pub(all) struct ImagetransformperspectiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_perspective_make_vector(comps : Array[Double]) -> ImagetransformperspectiveVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_perspective_vector_zero(dim : Int) -> ImagetransformperspectiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformperspectiveVector::add(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformperspectiveVector::sub(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformperspectiveVector::scale(self : ImagetransformperspectiveVector, s : Double) -> ImagetransformperspectiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformperspectiveVector::dot(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformperspectiveVector::norm(self : ImagetransformperspectiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformperspectiveVector::normalize(self : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformperspectiveVector::dist(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformperspectiveVector::to_string(self : ImagetransformperspectiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformperspectiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_frame_make(size : Int) -> ImagetransformperspectiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveFrame::len(self : ImagetransformperspectiveFrame) -> Int { self.size }

pub fn ImagetransformperspectiveFrame::get(self : ImagetransformperspectiveFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveFrame::set(self : ImagetransformperspectiveFrame, i : Int, v : Double) -> ImagetransformperspectiveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveFrame::sum(self : ImagetransformperspectiveFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveFrame::mean(self : ImagetransformperspectiveFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveFrame::scale(self : ImagetransformperspectiveFrame, f : Double) -> ImagetransformperspectiveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveFrame::add(self : ImagetransformperspectiveFrame, other : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveFrame::copy(self : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveFrame::fill(self : ImagetransformperspectiveFrame, v : Double) -> ImagetransformperspectiveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveFrame::min(self : ImagetransformperspectiveFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveFrame::max(self : ImagetransformperspectiveFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveFrame::to_string(self : ImagetransformperspectiveFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_table_make(size : Int) -> ImagetransformperspectiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveTable::len(self : ImagetransformperspectiveTable) -> Int { self.size }

pub fn ImagetransformperspectiveTable::get(self : ImagetransformperspectiveTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveTable::set(self : ImagetransformperspectiveTable, i : Int, v : Double) -> ImagetransformperspectiveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveTable::sum(self : ImagetransformperspectiveTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveTable::mean(self : ImagetransformperspectiveTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveTable::scale(self : ImagetransformperspectiveTable, f : Double) -> ImagetransformperspectiveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveTable::add(self : ImagetransformperspectiveTable, other : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveTable::copy(self : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveTable::fill(self : ImagetransformperspectiveTable, v : Double) -> ImagetransformperspectiveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveTable::min(self : ImagetransformperspectiveTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveTable::max(self : ImagetransformperspectiveTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveTable::to_string(self : ImagetransformperspectiveTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_graphn_make(size : Int) -> ImagetransformperspectiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveGraphN::len(self : ImagetransformperspectiveGraphN) -> Int { self.size }

pub fn ImagetransformperspectiveGraphN::get(self : ImagetransformperspectiveGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveGraphN::set(self : ImagetransformperspectiveGraphN, i : Int, v : Double) -> ImagetransformperspectiveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveGraphN::sum(self : ImagetransformperspectiveGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveGraphN::mean(self : ImagetransformperspectiveGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveGraphN::scale(self : ImagetransformperspectiveGraphN, f : Double) -> ImagetransformperspectiveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveGraphN::add(self : ImagetransformperspectiveGraphN, other : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveGraphN::copy(self : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveGraphN::fill(self : ImagetransformperspectiveGraphN, v : Double) -> ImagetransformperspectiveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveGraphN::min(self : ImagetransformperspectiveGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveGraphN::max(self : ImagetransformperspectiveGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveGraphN::to_string(self : ImagetransformperspectiveGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_node_make(size : Int) -> ImagetransformperspectiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveNode::len(self : ImagetransformperspectiveNode) -> Int { self.size }

pub fn ImagetransformperspectiveNode::get(self : ImagetransformperspectiveNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveNode::set(self : ImagetransformperspectiveNode, i : Int, v : Double) -> ImagetransformperspectiveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveNode::sum(self : ImagetransformperspectiveNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveNode::mean(self : ImagetransformperspectiveNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveNode::scale(self : ImagetransformperspectiveNode, f : Double) -> ImagetransformperspectiveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveNode::add(self : ImagetransformperspectiveNode, other : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveNode::copy(self : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveNode::fill(self : ImagetransformperspectiveNode, v : Double) -> ImagetransformperspectiveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveNode::min(self : ImagetransformperspectiveNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveNode::max(self : ImagetransformperspectiveNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveNode::to_string(self : ImagetransformperspectiveNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_edge_make(size : Int) -> ImagetransformperspectiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveEdge::len(self : ImagetransformperspectiveEdge) -> Int { self.size }

pub fn ImagetransformperspectiveEdge::get(self : ImagetransformperspectiveEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveEdge::set(self : ImagetransformperspectiveEdge, i : Int, v : Double) -> ImagetransformperspectiveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveEdge::sum(self : ImagetransformperspectiveEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveEdge::mean(self : ImagetransformperspectiveEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveEdge::scale(self : ImagetransformperspectiveEdge, f : Double) -> ImagetransformperspectiveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveEdge::add(self : ImagetransformperspectiveEdge, other : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveEdge::copy(self : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveEdge::fill(self : ImagetransformperspectiveEdge, v : Double) -> ImagetransformperspectiveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveEdge::min(self : ImagetransformperspectiveEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveEdge::max(self : ImagetransformperspectiveEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveEdge::to_string(self : ImagetransformperspectiveEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_path_make(size : Int) -> ImagetransformperspectivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectivePath::len(self : ImagetransformperspectivePath) -> Int { self.size }

pub fn ImagetransformperspectivePath::get(self : ImagetransformperspectivePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectivePath::set(self : ImagetransformperspectivePath, i : Int, v : Double) -> ImagetransformperspectivePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectivePath::sum(self : ImagetransformperspectivePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectivePath::mean(self : ImagetransformperspectivePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectivePath::scale(self : ImagetransformperspectivePath, f : Double) -> ImagetransformperspectivePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectivePath::add(self : ImagetransformperspectivePath, other : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectivePath::copy(self : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectivePath::fill(self : ImagetransformperspectivePath, v : Double) -> ImagetransformperspectivePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectivePath::min(self : ImagetransformperspectivePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectivePath::max(self : ImagetransformperspectivePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectivePath::to_string(self : ImagetransformperspectivePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cluster_make(size : Int) -> ImagetransformperspectiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveCluster::len(self : ImagetransformperspectiveCluster) -> Int { self.size }

pub fn ImagetransformperspectiveCluster::get(self : ImagetransformperspectiveCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveCluster::set(self : ImagetransformperspectiveCluster, i : Int, v : Double) -> ImagetransformperspectiveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCluster::sum(self : ImagetransformperspectiveCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveCluster::mean(self : ImagetransformperspectiveCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveCluster::scale(self : ImagetransformperspectiveCluster, f : Double) -> ImagetransformperspectiveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCluster::add(self : ImagetransformperspectiveCluster, other : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveCluster::copy(self : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCluster::fill(self : ImagetransformperspectiveCluster, v : Double) -> ImagetransformperspectiveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCluster::min(self : ImagetransformperspectiveCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveCluster::max(self : ImagetransformperspectiveCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveCluster::to_string(self : ImagetransformperspectiveCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_model_make(size : Int) -> ImagetransformperspectiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveModel::len(self : ImagetransformperspectiveModel) -> Int { self.size }

pub fn ImagetransformperspectiveModel::get(self : ImagetransformperspectiveModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveModel::set(self : ImagetransformperspectiveModel, i : Int, v : Double) -> ImagetransformperspectiveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveModel::sum(self : ImagetransformperspectiveModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveModel::mean(self : ImagetransformperspectiveModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveModel::scale(self : ImagetransformperspectiveModel, f : Double) -> ImagetransformperspectiveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveModel::add(self : ImagetransformperspectiveModel, other : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveModel::copy(self : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveModel::fill(self : ImagetransformperspectiveModel, v : Double) -> ImagetransformperspectiveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveModel::min(self : ImagetransformperspectiveModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveModel::max(self : ImagetransformperspectiveModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveModel::to_string(self : ImagetransformperspectiveModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_layer_make(size : Int) -> ImagetransformperspectiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveLayer::len(self : ImagetransformperspectiveLayer) -> Int { self.size }

pub fn ImagetransformperspectiveLayer::get(self : ImagetransformperspectiveLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveLayer::set(self : ImagetransformperspectiveLayer, i : Int, v : Double) -> ImagetransformperspectiveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveLayer::sum(self : ImagetransformperspectiveLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveLayer::mean(self : ImagetransformperspectiveLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveLayer::scale(self : ImagetransformperspectiveLayer, f : Double) -> ImagetransformperspectiveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveLayer::add(self : ImagetransformperspectiveLayer, other : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveLayer::copy(self : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveLayer::fill(self : ImagetransformperspectiveLayer, v : Double) -> ImagetransformperspectiveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveLayer::min(self : ImagetransformperspectiveLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveLayer::max(self : ImagetransformperspectiveLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveLayer::to_string(self : ImagetransformperspectiveLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_buffer_make(size : Int) -> ImagetransformperspectiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveBuffer::len(self : ImagetransformperspectiveBuffer) -> Int { self.size }

pub fn ImagetransformperspectiveBuffer::get(self : ImagetransformperspectiveBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveBuffer::set(self : ImagetransformperspectiveBuffer, i : Int, v : Double) -> ImagetransformperspectiveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveBuffer::sum(self : ImagetransformperspectiveBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveBuffer::mean(self : ImagetransformperspectiveBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveBuffer::scale(self : ImagetransformperspectiveBuffer, f : Double) -> ImagetransformperspectiveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveBuffer::add(self : ImagetransformperspectiveBuffer, other : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveBuffer::copy(self : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveBuffer::fill(self : ImagetransformperspectiveBuffer, v : Double) -> ImagetransformperspectiveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveBuffer::min(self : ImagetransformperspectiveBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveBuffer::max(self : ImagetransformperspectiveBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveBuffer::to_string(self : ImagetransformperspectiveBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cursor_make(size : Int) -> ImagetransformperspectiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveCursor::len(self : ImagetransformperspectiveCursor) -> Int { self.size }

pub fn ImagetransformperspectiveCursor::get(self : ImagetransformperspectiveCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveCursor::set(self : ImagetransformperspectiveCursor, i : Int, v : Double) -> ImagetransformperspectiveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCursor::sum(self : ImagetransformperspectiveCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveCursor::mean(self : ImagetransformperspectiveCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveCursor::scale(self : ImagetransformperspectiveCursor, f : Double) -> ImagetransformperspectiveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCursor::add(self : ImagetransformperspectiveCursor, other : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveCursor::copy(self : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCursor::fill(self : ImagetransformperspectiveCursor, v : Double) -> ImagetransformperspectiveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveCursor::min(self : ImagetransformperspectiveCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveCursor::max(self : ImagetransformperspectiveCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveCursor::to_string(self : ImagetransformperspectiveCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_view_make(size : Int) -> ImagetransformperspectiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveView::len(self : ImagetransformperspectiveView) -> Int { self.size }

pub fn ImagetransformperspectiveView::get(self : ImagetransformperspectiveView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveView::set(self : ImagetransformperspectiveView, i : Int, v : Double) -> ImagetransformperspectiveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveView::sum(self : ImagetransformperspectiveView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveView::mean(self : ImagetransformperspectiveView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveView::scale(self : ImagetransformperspectiveView, f : Double) -> ImagetransformperspectiveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveView::add(self : ImagetransformperspectiveView, other : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveView::copy(self : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveView::fill(self : ImagetransformperspectiveView, v : Double) -> ImagetransformperspectiveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveView::min(self : ImagetransformperspectiveView) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveView::max(self : ImagetransformperspectiveView) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveView::to_string(self : ImagetransformperspectiveView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_range_make(size : Int) -> ImagetransformperspectiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveRange::len(self : ImagetransformperspectiveRange) -> Int { self.size }

pub fn ImagetransformperspectiveRange::get(self : ImagetransformperspectiveRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveRange::set(self : ImagetransformperspectiveRange, i : Int, v : Double) -> ImagetransformperspectiveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveRange::sum(self : ImagetransformperspectiveRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveRange::mean(self : ImagetransformperspectiveRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveRange::scale(self : ImagetransformperspectiveRange, f : Double) -> ImagetransformperspectiveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveRange::add(self : ImagetransformperspectiveRange, other : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveRange::copy(self : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveRange::fill(self : ImagetransformperspectiveRange, v : Double) -> ImagetransformperspectiveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveRange::min(self : ImagetransformperspectiveRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveRange::max(self : ImagetransformperspectiveRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveRange::to_string(self : ImagetransformperspectiveRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_slice_make(size : Int) -> ImagetransformperspectiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformperspectiveSlice::len(self : ImagetransformperspectiveSlice) -> Int { self.size }

pub fn ImagetransformperspectiveSlice::get(self : ImagetransformperspectiveSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformperspectiveSlice::set(self : ImagetransformperspectiveSlice, i : Int, v : Double) -> ImagetransformperspectiveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveSlice::sum(self : ImagetransformperspectiveSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformperspectiveSlice::mean(self : ImagetransformperspectiveSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformperspectiveSlice::scale(self : ImagetransformperspectiveSlice, f : Double) -> ImagetransformperspectiveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveSlice::add(self : ImagetransformperspectiveSlice, other : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformperspectiveSlice::copy(self : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveSlice::fill(self : ImagetransformperspectiveSlice, v : Double) -> ImagetransformperspectiveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformperspectiveSlice::min(self : ImagetransformperspectiveSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformperspectiveSlice::max(self : ImagetransformperspectiveSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformperspectiveSlice::to_string(self : ImagetransformperspectiveSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

