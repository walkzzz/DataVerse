///===
/// extcore/image_transform_shear

pub(all) struct ImagetransformshearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_shear_make_point(x : Double, y : Double) -> ImagetransformshearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_shear_make_point3(x : Double, y : Double, z : Double) -> ImagetransformshearPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformshearPoint::x(self : ImagetransformshearPoint) -> Double { self.x }

pub fn ImagetransformshearPoint::y(self : ImagetransformshearPoint) -> Double { self.y }

pub fn ImagetransformshearPoint::z(self : ImagetransformshearPoint) -> Double { self.z }

pub fn ImagetransformshearPoint::label(self : ImagetransformshearPoint) -> Int { self.label }

pub fn ImagetransformshearPoint::dist(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformshearPoint::add(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformshearPoint::sub(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformshearPoint::scale(self : ImagetransformshearPoint, s : Double) -> ImagetransformshearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformshearPoint::dot(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformshearPoint::cross(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformshearPoint::norm(self : ImagetransformshearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformshearPoint::normalize(self : ImagetransformshearPoint) -> ImagetransformshearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformshearPoint::negate(self : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformshearPoint::mid(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformshearPoint::lerp(self : ImagetransformshearPoint, other : ImagetransformshearPoint, t : Double) -> ImagetransformshearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformshearPoint::to_string(self : ImagetransformshearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformshearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_shear_make_series(vals : Array[Double], name : String) -> ImagetransformshearSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformshearSeries::len(self : ImagetransformshearSeries) -> Int { self.vals.length() }

pub fn ImagetransformshearSeries::sum(self : ImagetransformshearSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformshearSeries::mean(self : ImagetransformshearSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformshearSeries::min(self : ImagetransformshearSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformshearSeries::max(self : ImagetransformshearSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformshearSeries::range(self : ImagetransformshearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformshearSeries::variance(self : ImagetransformshearSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformshearSeries::std(self : ImagetransformshearSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformshearSeries::median(self : ImagetransformshearSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformshearSeries::scale(self : ImagetransformshearSeries, f : Double) -> ImagetransformshearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::add(self : ImagetransformshearSeries, other : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::sub(self : ImagetransformshearSeries, other : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::normalize(self : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformshearSeries::cumsum(self : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformshearSeries::to_string(self : ImagetransformshearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformshearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_shear_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformshearMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_transform_shear_matrix_identity(n : Int) -> ImagetransformshearMatrix {
  let m = image_transform_shear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformshearMatrix::get(self : ImagetransformshearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformshearMatrix::transpose(self : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformshearMatrix::add(self : ImagetransformshearMatrix, other : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_shear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformshearMatrix::scale(self : ImagetransformshearMatrix, s : Double) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformshearMatrix::multiply(self : ImagetransformshearMatrix, other : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if self.cols != other.rows { return image_transform_shear_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_shear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformshearMatrix::trace(self : ImagetransformshearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformshearMatrix::det(self : ImagetransformshearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformshearMatrix::norm(self : ImagetransformshearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformshearMatrix::to_string(self : ImagetransformshearMatrix) -> String {
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

pub(all) struct ImagetransformshearVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_shear_make_vector(comps : Array[Double]) -> ImagetransformshearVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_shear_vector_zero(dim : Int) -> ImagetransformshearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformshearVector::add(self : ImagetransformshearVector, other : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformshearVector::sub(self : ImagetransformshearVector, other : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformshearVector::scale(self : ImagetransformshearVector, s : Double) -> ImagetransformshearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformshearVector::dot(self : ImagetransformshearVector, other : ImagetransformshearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformshearVector::norm(self : ImagetransformshearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformshearVector::normalize(self : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformshearVector::dist(self : ImagetransformshearVector, other : ImagetransformshearVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformshearVector::to_string(self : ImagetransformshearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformshearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_frame_make(size : Int) -> ImagetransformshearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearFrame::len(self : ImagetransformshearFrame) -> Int { self.size }

pub fn ImagetransformshearFrame::get(self : ImagetransformshearFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearFrame::set(self : ImagetransformshearFrame, i : Int, v : Double) -> ImagetransformshearFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearFrame::sum(self : ImagetransformshearFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearFrame::mean(self : ImagetransformshearFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearFrame::scale(self : ImagetransformshearFrame, f : Double) -> ImagetransformshearFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearFrame::add(self : ImagetransformshearFrame, other : ImagetransformshearFrame) -> ImagetransformshearFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearFrame::copy(self : ImagetransformshearFrame) -> ImagetransformshearFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearFrame::fill(self : ImagetransformshearFrame, v : Double) -> ImagetransformshearFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearFrame::min(self : ImagetransformshearFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearFrame::max(self : ImagetransformshearFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearFrame::to_string(self : ImagetransformshearFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_table_make(size : Int) -> ImagetransformshearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearTable::len(self : ImagetransformshearTable) -> Int { self.size }

pub fn ImagetransformshearTable::get(self : ImagetransformshearTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearTable::set(self : ImagetransformshearTable, i : Int, v : Double) -> ImagetransformshearTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearTable::sum(self : ImagetransformshearTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearTable::mean(self : ImagetransformshearTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearTable::scale(self : ImagetransformshearTable, f : Double) -> ImagetransformshearTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearTable::add(self : ImagetransformshearTable, other : ImagetransformshearTable) -> ImagetransformshearTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearTable::copy(self : ImagetransformshearTable) -> ImagetransformshearTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearTable::fill(self : ImagetransformshearTable, v : Double) -> ImagetransformshearTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearTable::min(self : ImagetransformshearTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearTable::max(self : ImagetransformshearTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearTable::to_string(self : ImagetransformshearTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_graphn_make(size : Int) -> ImagetransformshearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearGraphN::len(self : ImagetransformshearGraphN) -> Int { self.size }

pub fn ImagetransformshearGraphN::get(self : ImagetransformshearGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearGraphN::set(self : ImagetransformshearGraphN, i : Int, v : Double) -> ImagetransformshearGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearGraphN::sum(self : ImagetransformshearGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearGraphN::mean(self : ImagetransformshearGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearGraphN::scale(self : ImagetransformshearGraphN, f : Double) -> ImagetransformshearGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearGraphN::add(self : ImagetransformshearGraphN, other : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearGraphN::copy(self : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearGraphN::fill(self : ImagetransformshearGraphN, v : Double) -> ImagetransformshearGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearGraphN::min(self : ImagetransformshearGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearGraphN::max(self : ImagetransformshearGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearGraphN::to_string(self : ImagetransformshearGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_node_make(size : Int) -> ImagetransformshearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearNode::len(self : ImagetransformshearNode) -> Int { self.size }

pub fn ImagetransformshearNode::get(self : ImagetransformshearNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearNode::set(self : ImagetransformshearNode, i : Int, v : Double) -> ImagetransformshearNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearNode::sum(self : ImagetransformshearNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearNode::mean(self : ImagetransformshearNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearNode::scale(self : ImagetransformshearNode, f : Double) -> ImagetransformshearNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearNode::add(self : ImagetransformshearNode, other : ImagetransformshearNode) -> ImagetransformshearNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearNode::copy(self : ImagetransformshearNode) -> ImagetransformshearNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearNode::fill(self : ImagetransformshearNode, v : Double) -> ImagetransformshearNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearNode::min(self : ImagetransformshearNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearNode::max(self : ImagetransformshearNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearNode::to_string(self : ImagetransformshearNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_edge_make(size : Int) -> ImagetransformshearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearEdge::len(self : ImagetransformshearEdge) -> Int { self.size }

pub fn ImagetransformshearEdge::get(self : ImagetransformshearEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearEdge::set(self : ImagetransformshearEdge, i : Int, v : Double) -> ImagetransformshearEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearEdge::sum(self : ImagetransformshearEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearEdge::mean(self : ImagetransformshearEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearEdge::scale(self : ImagetransformshearEdge, f : Double) -> ImagetransformshearEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearEdge::add(self : ImagetransformshearEdge, other : ImagetransformshearEdge) -> ImagetransformshearEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearEdge::copy(self : ImagetransformshearEdge) -> ImagetransformshearEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearEdge::fill(self : ImagetransformshearEdge, v : Double) -> ImagetransformshearEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearEdge::min(self : ImagetransformshearEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearEdge::max(self : ImagetransformshearEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearEdge::to_string(self : ImagetransformshearEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_path_make(size : Int) -> ImagetransformshearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearPath::len(self : ImagetransformshearPath) -> Int { self.size }

pub fn ImagetransformshearPath::get(self : ImagetransformshearPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearPath::set(self : ImagetransformshearPath, i : Int, v : Double) -> ImagetransformshearPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearPath::sum(self : ImagetransformshearPath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearPath::mean(self : ImagetransformshearPath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearPath::scale(self : ImagetransformshearPath, f : Double) -> ImagetransformshearPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearPath::add(self : ImagetransformshearPath, other : ImagetransformshearPath) -> ImagetransformshearPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearPath::copy(self : ImagetransformshearPath) -> ImagetransformshearPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearPath::fill(self : ImagetransformshearPath, v : Double) -> ImagetransformshearPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearPath::min(self : ImagetransformshearPath) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearPath::max(self : ImagetransformshearPath) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearPath::to_string(self : ImagetransformshearPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cluster_make(size : Int) -> ImagetransformshearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearCluster::len(self : ImagetransformshearCluster) -> Int { self.size }

pub fn ImagetransformshearCluster::get(self : ImagetransformshearCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearCluster::set(self : ImagetransformshearCluster, i : Int, v : Double) -> ImagetransformshearCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCluster::sum(self : ImagetransformshearCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearCluster::mean(self : ImagetransformshearCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearCluster::scale(self : ImagetransformshearCluster, f : Double) -> ImagetransformshearCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCluster::add(self : ImagetransformshearCluster, other : ImagetransformshearCluster) -> ImagetransformshearCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearCluster::copy(self : ImagetransformshearCluster) -> ImagetransformshearCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCluster::fill(self : ImagetransformshearCluster, v : Double) -> ImagetransformshearCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCluster::min(self : ImagetransformshearCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearCluster::max(self : ImagetransformshearCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearCluster::to_string(self : ImagetransformshearCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_model_make(size : Int) -> ImagetransformshearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearModel::len(self : ImagetransformshearModel) -> Int { self.size }

pub fn ImagetransformshearModel::get(self : ImagetransformshearModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearModel::set(self : ImagetransformshearModel, i : Int, v : Double) -> ImagetransformshearModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearModel::sum(self : ImagetransformshearModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearModel::mean(self : ImagetransformshearModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearModel::scale(self : ImagetransformshearModel, f : Double) -> ImagetransformshearModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearModel::add(self : ImagetransformshearModel, other : ImagetransformshearModel) -> ImagetransformshearModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearModel::copy(self : ImagetransformshearModel) -> ImagetransformshearModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearModel::fill(self : ImagetransformshearModel, v : Double) -> ImagetransformshearModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearModel::min(self : ImagetransformshearModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearModel::max(self : ImagetransformshearModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearModel::to_string(self : ImagetransformshearModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_layer_make(size : Int) -> ImagetransformshearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearLayer::len(self : ImagetransformshearLayer) -> Int { self.size }

pub fn ImagetransformshearLayer::get(self : ImagetransformshearLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearLayer::set(self : ImagetransformshearLayer, i : Int, v : Double) -> ImagetransformshearLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearLayer::sum(self : ImagetransformshearLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearLayer::mean(self : ImagetransformshearLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearLayer::scale(self : ImagetransformshearLayer, f : Double) -> ImagetransformshearLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearLayer::add(self : ImagetransformshearLayer, other : ImagetransformshearLayer) -> ImagetransformshearLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearLayer::copy(self : ImagetransformshearLayer) -> ImagetransformshearLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearLayer::fill(self : ImagetransformshearLayer, v : Double) -> ImagetransformshearLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearLayer::min(self : ImagetransformshearLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearLayer::max(self : ImagetransformshearLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearLayer::to_string(self : ImagetransformshearLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_buffer_make(size : Int) -> ImagetransformshearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearBuffer::len(self : ImagetransformshearBuffer) -> Int { self.size }

pub fn ImagetransformshearBuffer::get(self : ImagetransformshearBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearBuffer::set(self : ImagetransformshearBuffer, i : Int, v : Double) -> ImagetransformshearBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearBuffer::sum(self : ImagetransformshearBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearBuffer::mean(self : ImagetransformshearBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearBuffer::scale(self : ImagetransformshearBuffer, f : Double) -> ImagetransformshearBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearBuffer::add(self : ImagetransformshearBuffer, other : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearBuffer::copy(self : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearBuffer::fill(self : ImagetransformshearBuffer, v : Double) -> ImagetransformshearBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearBuffer::min(self : ImagetransformshearBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearBuffer::max(self : ImagetransformshearBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearBuffer::to_string(self : ImagetransformshearBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cursor_make(size : Int) -> ImagetransformshearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearCursor::len(self : ImagetransformshearCursor) -> Int { self.size }

pub fn ImagetransformshearCursor::get(self : ImagetransformshearCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearCursor::set(self : ImagetransformshearCursor, i : Int, v : Double) -> ImagetransformshearCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCursor::sum(self : ImagetransformshearCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearCursor::mean(self : ImagetransformshearCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearCursor::scale(self : ImagetransformshearCursor, f : Double) -> ImagetransformshearCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCursor::add(self : ImagetransformshearCursor, other : ImagetransformshearCursor) -> ImagetransformshearCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearCursor::copy(self : ImagetransformshearCursor) -> ImagetransformshearCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCursor::fill(self : ImagetransformshearCursor, v : Double) -> ImagetransformshearCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearCursor::min(self : ImagetransformshearCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearCursor::max(self : ImagetransformshearCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearCursor::to_string(self : ImagetransformshearCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_view_make(size : Int) -> ImagetransformshearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearView::len(self : ImagetransformshearView) -> Int { self.size }

pub fn ImagetransformshearView::get(self : ImagetransformshearView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearView::set(self : ImagetransformshearView, i : Int, v : Double) -> ImagetransformshearView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearView::sum(self : ImagetransformshearView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearView::mean(self : ImagetransformshearView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearView::scale(self : ImagetransformshearView, f : Double) -> ImagetransformshearView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearView::add(self : ImagetransformshearView, other : ImagetransformshearView) -> ImagetransformshearView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearView::copy(self : ImagetransformshearView) -> ImagetransformshearView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearView::fill(self : ImagetransformshearView, v : Double) -> ImagetransformshearView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearView::min(self : ImagetransformshearView) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearView::max(self : ImagetransformshearView) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearView::to_string(self : ImagetransformshearView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_range_make(size : Int) -> ImagetransformshearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearRange::len(self : ImagetransformshearRange) -> Int { self.size }

pub fn ImagetransformshearRange::get(self : ImagetransformshearRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearRange::set(self : ImagetransformshearRange, i : Int, v : Double) -> ImagetransformshearRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearRange::sum(self : ImagetransformshearRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearRange::mean(self : ImagetransformshearRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearRange::scale(self : ImagetransformshearRange, f : Double) -> ImagetransformshearRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearRange::add(self : ImagetransformshearRange, other : ImagetransformshearRange) -> ImagetransformshearRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearRange::copy(self : ImagetransformshearRange) -> ImagetransformshearRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearRange::fill(self : ImagetransformshearRange, v : Double) -> ImagetransformshearRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearRange::min(self : ImagetransformshearRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearRange::max(self : ImagetransformshearRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearRange::to_string(self : ImagetransformshearRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_slice_make(size : Int) -> ImagetransformshearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformshearSlice::len(self : ImagetransformshearSlice) -> Int { self.size }

pub fn ImagetransformshearSlice::get(self : ImagetransformshearSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformshearSlice::set(self : ImagetransformshearSlice, i : Int, v : Double) -> ImagetransformshearSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformshearSlice::sum(self : ImagetransformshearSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformshearSlice::mean(self : ImagetransformshearSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformshearSlice::scale(self : ImagetransformshearSlice, f : Double) -> ImagetransformshearSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearSlice::add(self : ImagetransformshearSlice, other : ImagetransformshearSlice) -> ImagetransformshearSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformshearSlice::copy(self : ImagetransformshearSlice) -> ImagetransformshearSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearSlice::fill(self : ImagetransformshearSlice, v : Double) -> ImagetransformshearSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformshearSlice::min(self : ImagetransformshearSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformshearSlice::max(self : ImagetransformshearSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformshearSlice::to_string(self : ImagetransformshearSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

