///===
/// extcore/image_transform_transpose

pub(all) struct ImagetransformtransposePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_transpose_make_point(x : Double, y : Double) -> ImagetransformtransposePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_transpose_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtransposePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformtransposePoint::x(self : ImagetransformtransposePoint) -> Double { self.x }

pub fn ImagetransformtransposePoint::y(self : ImagetransformtransposePoint) -> Double { self.y }

pub fn ImagetransformtransposePoint::z(self : ImagetransformtransposePoint) -> Double { self.z }

pub fn ImagetransformtransposePoint::label(self : ImagetransformtransposePoint) -> Int { self.label }

pub fn ImagetransformtransposePoint::dist(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformtransposePoint::add(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformtransposePoint::sub(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformtransposePoint::scale(self : ImagetransformtransposePoint, s : Double) -> ImagetransformtransposePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformtransposePoint::dot(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformtransposePoint::cross(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformtransposePoint::norm(self : ImagetransformtransposePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformtransposePoint::normalize(self : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtransposePoint::negate(self : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformtransposePoint::mid(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformtransposePoint::lerp(self : ImagetransformtransposePoint, other : ImagetransformtransposePoint, t : Double) -> ImagetransformtransposePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformtransposePoint::to_string(self : ImagetransformtransposePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_transpose_make_series(vals : Array[Double], name : String) -> ImagetransformtransposeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformtransposeSeries::len(self : ImagetransformtransposeSeries) -> Int { self.vals.length() }

pub fn ImagetransformtransposeSeries::sum(self : ImagetransformtransposeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformtransposeSeries::mean(self : ImagetransformtransposeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformtransposeSeries::min(self : ImagetransformtransposeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformtransposeSeries::max(self : ImagetransformtransposeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformtransposeSeries::range(self : ImagetransformtransposeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformtransposeSeries::variance(self : ImagetransformtransposeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformtransposeSeries::std(self : ImagetransformtransposeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformtransposeSeries::median(self : ImagetransformtransposeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformtransposeSeries::scale(self : ImagetransformtransposeSeries, f : Double) -> ImagetransformtransposeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformtransposeSeries::add(self : ImagetransformtransposeSeries, other : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformtransposeSeries::sub(self : ImagetransformtransposeSeries, other : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformtransposeSeries::normalize(self : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformtransposeSeries::cumsum(self : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformtransposeSeries::to_string(self : ImagetransformtransposeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtransposeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_transpose_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtransposeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_transpose_matrix_identity(n : Int) -> ImagetransformtransposeMatrix {
  let m = image_transform_transpose_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformtransposeMatrix::get(self : ImagetransformtransposeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformtransposeMatrix::transpose(self : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformtransposeMatrix::add(self : ImagetransformtransposeMatrix, other : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_transpose_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformtransposeMatrix::scale(self : ImagetransformtransposeMatrix, s : Double) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformtransposeMatrix::multiply(self : ImagetransformtransposeMatrix, other : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if self.cols != other.rows { return image_transform_transpose_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_transpose_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformtransposeMatrix::trace(self : ImagetransformtransposeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformtransposeMatrix::det(self : ImagetransformtransposeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformtransposeMatrix::norm(self : ImagetransformtransposeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformtransposeMatrix::to_string(self : ImagetransformtransposeMatrix) -> String {
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

pub(all) struct ImagetransformtransposeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_transpose_make_vector(comps : Array[Double]) -> ImagetransformtransposeVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_transpose_vector_zero(dim : Int) -> ImagetransformtransposeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformtransposeVector::add(self : ImagetransformtransposeVector, other : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtransposeVector::sub(self : ImagetransformtransposeVector, other : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtransposeVector::scale(self : ImagetransformtransposeVector, s : Double) -> ImagetransformtransposeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformtransposeVector::dot(self : ImagetransformtransposeVector, other : ImagetransformtransposeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformtransposeVector::norm(self : ImagetransformtransposeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformtransposeVector::normalize(self : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtransposeVector::dist(self : ImagetransformtransposeVector, other : ImagetransformtransposeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformtransposeVector::to_string(self : ImagetransformtransposeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtransposeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_frame_make(size : Int) -> ImagetransformtransposeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeFrame::len(self : ImagetransformtransposeFrame) -> Int { self.size }

pub fn ImagetransformtransposeFrame::get(self : ImagetransformtransposeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeFrame::set(self : ImagetransformtransposeFrame, i : Int, v : Double) -> ImagetransformtransposeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeFrame::sum(self : ImagetransformtransposeFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeFrame::mean(self : ImagetransformtransposeFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeFrame::scale(self : ImagetransformtransposeFrame, f : Double) -> ImagetransformtransposeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeFrame::add(self : ImagetransformtransposeFrame, other : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeFrame::copy(self : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeFrame::fill(self : ImagetransformtransposeFrame, v : Double) -> ImagetransformtransposeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeFrame::min(self : ImagetransformtransposeFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeFrame::max(self : ImagetransformtransposeFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeFrame::to_string(self : ImagetransformtransposeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_table_make(size : Int) -> ImagetransformtransposeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeTable::len(self : ImagetransformtransposeTable) -> Int { self.size }

pub fn ImagetransformtransposeTable::get(self : ImagetransformtransposeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeTable::set(self : ImagetransformtransposeTable, i : Int, v : Double) -> ImagetransformtransposeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeTable::sum(self : ImagetransformtransposeTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeTable::mean(self : ImagetransformtransposeTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeTable::scale(self : ImagetransformtransposeTable, f : Double) -> ImagetransformtransposeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeTable::add(self : ImagetransformtransposeTable, other : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeTable::copy(self : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeTable::fill(self : ImagetransformtransposeTable, v : Double) -> ImagetransformtransposeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeTable::min(self : ImagetransformtransposeTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeTable::max(self : ImagetransformtransposeTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeTable::to_string(self : ImagetransformtransposeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_graphn_make(size : Int) -> ImagetransformtransposeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeGraphN::len(self : ImagetransformtransposeGraphN) -> Int { self.size }

pub fn ImagetransformtransposeGraphN::get(self : ImagetransformtransposeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeGraphN::set(self : ImagetransformtransposeGraphN, i : Int, v : Double) -> ImagetransformtransposeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeGraphN::sum(self : ImagetransformtransposeGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeGraphN::mean(self : ImagetransformtransposeGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeGraphN::scale(self : ImagetransformtransposeGraphN, f : Double) -> ImagetransformtransposeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeGraphN::add(self : ImagetransformtransposeGraphN, other : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeGraphN::copy(self : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeGraphN::fill(self : ImagetransformtransposeGraphN, v : Double) -> ImagetransformtransposeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeGraphN::min(self : ImagetransformtransposeGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeGraphN::max(self : ImagetransformtransposeGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeGraphN::to_string(self : ImagetransformtransposeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_node_make(size : Int) -> ImagetransformtransposeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeNode::len(self : ImagetransformtransposeNode) -> Int { self.size }

pub fn ImagetransformtransposeNode::get(self : ImagetransformtransposeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeNode::set(self : ImagetransformtransposeNode, i : Int, v : Double) -> ImagetransformtransposeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeNode::sum(self : ImagetransformtransposeNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeNode::mean(self : ImagetransformtransposeNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeNode::scale(self : ImagetransformtransposeNode, f : Double) -> ImagetransformtransposeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeNode::add(self : ImagetransformtransposeNode, other : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeNode::copy(self : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeNode::fill(self : ImagetransformtransposeNode, v : Double) -> ImagetransformtransposeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeNode::min(self : ImagetransformtransposeNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeNode::max(self : ImagetransformtransposeNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeNode::to_string(self : ImagetransformtransposeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_edge_make(size : Int) -> ImagetransformtransposeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeEdge::len(self : ImagetransformtransposeEdge) -> Int { self.size }

pub fn ImagetransformtransposeEdge::get(self : ImagetransformtransposeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeEdge::set(self : ImagetransformtransposeEdge, i : Int, v : Double) -> ImagetransformtransposeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeEdge::sum(self : ImagetransformtransposeEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeEdge::mean(self : ImagetransformtransposeEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeEdge::scale(self : ImagetransformtransposeEdge, f : Double) -> ImagetransformtransposeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeEdge::add(self : ImagetransformtransposeEdge, other : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeEdge::copy(self : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeEdge::fill(self : ImagetransformtransposeEdge, v : Double) -> ImagetransformtransposeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeEdge::min(self : ImagetransformtransposeEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeEdge::max(self : ImagetransformtransposeEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeEdge::to_string(self : ImagetransformtransposeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_path_make(size : Int) -> ImagetransformtransposePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposePath::len(self : ImagetransformtransposePath) -> Int { self.size }

pub fn ImagetransformtransposePath::get(self : ImagetransformtransposePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposePath::set(self : ImagetransformtransposePath, i : Int, v : Double) -> ImagetransformtransposePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposePath::sum(self : ImagetransformtransposePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposePath::mean(self : ImagetransformtransposePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposePath::scale(self : ImagetransformtransposePath, f : Double) -> ImagetransformtransposePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposePath::add(self : ImagetransformtransposePath, other : ImagetransformtransposePath) -> ImagetransformtransposePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposePath::copy(self : ImagetransformtransposePath) -> ImagetransformtransposePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposePath::fill(self : ImagetransformtransposePath, v : Double) -> ImagetransformtransposePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposePath::min(self : ImagetransformtransposePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposePath::max(self : ImagetransformtransposePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposePath::to_string(self : ImagetransformtransposePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cluster_make(size : Int) -> ImagetransformtransposeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeCluster::len(self : ImagetransformtransposeCluster) -> Int { self.size }

pub fn ImagetransformtransposeCluster::get(self : ImagetransformtransposeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeCluster::set(self : ImagetransformtransposeCluster, i : Int, v : Double) -> ImagetransformtransposeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCluster::sum(self : ImagetransformtransposeCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeCluster::mean(self : ImagetransformtransposeCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeCluster::scale(self : ImagetransformtransposeCluster, f : Double) -> ImagetransformtransposeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCluster::add(self : ImagetransformtransposeCluster, other : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeCluster::copy(self : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCluster::fill(self : ImagetransformtransposeCluster, v : Double) -> ImagetransformtransposeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCluster::min(self : ImagetransformtransposeCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeCluster::max(self : ImagetransformtransposeCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeCluster::to_string(self : ImagetransformtransposeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_model_make(size : Int) -> ImagetransformtransposeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeModel::len(self : ImagetransformtransposeModel) -> Int { self.size }

pub fn ImagetransformtransposeModel::get(self : ImagetransformtransposeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeModel::set(self : ImagetransformtransposeModel, i : Int, v : Double) -> ImagetransformtransposeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeModel::sum(self : ImagetransformtransposeModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeModel::mean(self : ImagetransformtransposeModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeModel::scale(self : ImagetransformtransposeModel, f : Double) -> ImagetransformtransposeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeModel::add(self : ImagetransformtransposeModel, other : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeModel::copy(self : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeModel::fill(self : ImagetransformtransposeModel, v : Double) -> ImagetransformtransposeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeModel::min(self : ImagetransformtransposeModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeModel::max(self : ImagetransformtransposeModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeModel::to_string(self : ImagetransformtransposeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_layer_make(size : Int) -> ImagetransformtransposeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeLayer::len(self : ImagetransformtransposeLayer) -> Int { self.size }

pub fn ImagetransformtransposeLayer::get(self : ImagetransformtransposeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeLayer::set(self : ImagetransformtransposeLayer, i : Int, v : Double) -> ImagetransformtransposeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeLayer::sum(self : ImagetransformtransposeLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeLayer::mean(self : ImagetransformtransposeLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeLayer::scale(self : ImagetransformtransposeLayer, f : Double) -> ImagetransformtransposeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeLayer::add(self : ImagetransformtransposeLayer, other : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeLayer::copy(self : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeLayer::fill(self : ImagetransformtransposeLayer, v : Double) -> ImagetransformtransposeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeLayer::min(self : ImagetransformtransposeLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeLayer::max(self : ImagetransformtransposeLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeLayer::to_string(self : ImagetransformtransposeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_buffer_make(size : Int) -> ImagetransformtransposeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeBuffer::len(self : ImagetransformtransposeBuffer) -> Int { self.size }

pub fn ImagetransformtransposeBuffer::get(self : ImagetransformtransposeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeBuffer::set(self : ImagetransformtransposeBuffer, i : Int, v : Double) -> ImagetransformtransposeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeBuffer::sum(self : ImagetransformtransposeBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeBuffer::mean(self : ImagetransformtransposeBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeBuffer::scale(self : ImagetransformtransposeBuffer, f : Double) -> ImagetransformtransposeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeBuffer::add(self : ImagetransformtransposeBuffer, other : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeBuffer::copy(self : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeBuffer::fill(self : ImagetransformtransposeBuffer, v : Double) -> ImagetransformtransposeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeBuffer::min(self : ImagetransformtransposeBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeBuffer::max(self : ImagetransformtransposeBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeBuffer::to_string(self : ImagetransformtransposeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cursor_make(size : Int) -> ImagetransformtransposeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeCursor::len(self : ImagetransformtransposeCursor) -> Int { self.size }

pub fn ImagetransformtransposeCursor::get(self : ImagetransformtransposeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeCursor::set(self : ImagetransformtransposeCursor, i : Int, v : Double) -> ImagetransformtransposeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCursor::sum(self : ImagetransformtransposeCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeCursor::mean(self : ImagetransformtransposeCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeCursor::scale(self : ImagetransformtransposeCursor, f : Double) -> ImagetransformtransposeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCursor::add(self : ImagetransformtransposeCursor, other : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeCursor::copy(self : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCursor::fill(self : ImagetransformtransposeCursor, v : Double) -> ImagetransformtransposeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeCursor::min(self : ImagetransformtransposeCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeCursor::max(self : ImagetransformtransposeCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeCursor::to_string(self : ImagetransformtransposeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_view_make(size : Int) -> ImagetransformtransposeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeView::len(self : ImagetransformtransposeView) -> Int { self.size }

pub fn ImagetransformtransposeView::get(self : ImagetransformtransposeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeView::set(self : ImagetransformtransposeView, i : Int, v : Double) -> ImagetransformtransposeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeView::sum(self : ImagetransformtransposeView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeView::mean(self : ImagetransformtransposeView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeView::scale(self : ImagetransformtransposeView, f : Double) -> ImagetransformtransposeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeView::add(self : ImagetransformtransposeView, other : ImagetransformtransposeView) -> ImagetransformtransposeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeView::copy(self : ImagetransformtransposeView) -> ImagetransformtransposeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeView::fill(self : ImagetransformtransposeView, v : Double) -> ImagetransformtransposeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeView::min(self : ImagetransformtransposeView) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeView::max(self : ImagetransformtransposeView) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeView::to_string(self : ImagetransformtransposeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_range_make(size : Int) -> ImagetransformtransposeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeRange::len(self : ImagetransformtransposeRange) -> Int { self.size }

pub fn ImagetransformtransposeRange::get(self : ImagetransformtransposeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeRange::set(self : ImagetransformtransposeRange, i : Int, v : Double) -> ImagetransformtransposeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeRange::sum(self : ImagetransformtransposeRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeRange::mean(self : ImagetransformtransposeRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeRange::scale(self : ImagetransformtransposeRange, f : Double) -> ImagetransformtransposeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeRange::add(self : ImagetransformtransposeRange, other : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeRange::copy(self : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeRange::fill(self : ImagetransformtransposeRange, v : Double) -> ImagetransformtransposeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeRange::min(self : ImagetransformtransposeRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeRange::max(self : ImagetransformtransposeRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeRange::to_string(self : ImagetransformtransposeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_slice_make(size : Int) -> ImagetransformtransposeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtransposeSlice::len(self : ImagetransformtransposeSlice) -> Int { self.size }

pub fn ImagetransformtransposeSlice::get(self : ImagetransformtransposeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtransposeSlice::set(self : ImagetransformtransposeSlice, i : Int, v : Double) -> ImagetransformtransposeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeSlice::sum(self : ImagetransformtransposeSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtransposeSlice::mean(self : ImagetransformtransposeSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtransposeSlice::scale(self : ImagetransformtransposeSlice, f : Double) -> ImagetransformtransposeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeSlice::add(self : ImagetransformtransposeSlice, other : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtransposeSlice::copy(self : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeSlice::fill(self : ImagetransformtransposeSlice, v : Double) -> ImagetransformtransposeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtransposeSlice::min(self : ImagetransformtransposeSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformtransposeSlice::max(self : ImagetransformtransposeSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformtransposeSlice::to_string(self : ImagetransformtransposeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

