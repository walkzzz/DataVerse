///===
/// extcore/image_transform_remap

pub(all) struct ImagetransformremapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_remap_make_point(x : Double, y : Double) -> ImagetransformremapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_remap_make_point3(x : Double, y : Double, z : Double) -> ImagetransformremapPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformremapPoint::x(self : ImagetransformremapPoint) -> Double { self.x }

pub fn ImagetransformremapPoint::y(self : ImagetransformremapPoint) -> Double { self.y }

pub fn ImagetransformremapPoint::z(self : ImagetransformremapPoint) -> Double { self.z }

pub fn ImagetransformremapPoint::label(self : ImagetransformremapPoint) -> Int { self.label }

pub fn ImagetransformremapPoint::dist(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformremapPoint::add(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformremapPoint::sub(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformremapPoint::scale(self : ImagetransformremapPoint, s : Double) -> ImagetransformremapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformremapPoint::dot(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformremapPoint::cross(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformremapPoint::norm(self : ImagetransformremapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformremapPoint::normalize(self : ImagetransformremapPoint) -> ImagetransformremapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformremapPoint::negate(self : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformremapPoint::mid(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformremapPoint::lerp(self : ImagetransformremapPoint, other : ImagetransformremapPoint, t : Double) -> ImagetransformremapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformremapPoint::to_string(self : ImagetransformremapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformremapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_remap_make_series(vals : Array[Double], name : String) -> ImagetransformremapSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformremapSeries::len(self : ImagetransformremapSeries) -> Int { self.vals.length() }

pub fn ImagetransformremapSeries::sum(self : ImagetransformremapSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformremapSeries::mean(self : ImagetransformremapSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformremapSeries::min(self : ImagetransformremapSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformremapSeries::max(self : ImagetransformremapSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformremapSeries::range(self : ImagetransformremapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformremapSeries::variance(self : ImagetransformremapSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformremapSeries::std(self : ImagetransformremapSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformremapSeries::median(self : ImagetransformremapSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformremapSeries::scale(self : ImagetransformremapSeries, f : Double) -> ImagetransformremapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::add(self : ImagetransformremapSeries, other : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::sub(self : ImagetransformremapSeries, other : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::normalize(self : ImagetransformremapSeries) -> ImagetransformremapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformremapSeries::cumsum(self : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformremapSeries::to_string(self : ImagetransformremapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformremapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_remap_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformremapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_remap_matrix_identity(n : Int) -> ImagetransformremapMatrix {
  let m = image_transform_remap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformremapMatrix::get(self : ImagetransformremapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformremapMatrix::transpose(self : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformremapMatrix::add(self : ImagetransformremapMatrix, other : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_remap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformremapMatrix::scale(self : ImagetransformremapMatrix, s : Double) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformremapMatrix::multiply(self : ImagetransformremapMatrix, other : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if self.cols != other.rows { return image_transform_remap_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_remap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformremapMatrix::trace(self : ImagetransformremapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformremapMatrix::det(self : ImagetransformremapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformremapMatrix::norm(self : ImagetransformremapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformremapMatrix::to_string(self : ImagetransformremapMatrix) -> String {
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

pub(all) struct ImagetransformremapVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_remap_make_vector(comps : Array[Double]) -> ImagetransformremapVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_remap_vector_zero(dim : Int) -> ImagetransformremapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformremapVector::add(self : ImagetransformremapVector, other : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformremapVector::sub(self : ImagetransformremapVector, other : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformremapVector::scale(self : ImagetransformremapVector, s : Double) -> ImagetransformremapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformremapVector::dot(self : ImagetransformremapVector, other : ImagetransformremapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformremapVector::norm(self : ImagetransformremapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformremapVector::normalize(self : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformremapVector::dist(self : ImagetransformremapVector, other : ImagetransformremapVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformremapVector::to_string(self : ImagetransformremapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformremapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_frame_make(size : Int) -> ImagetransformremapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapFrame::len(self : ImagetransformremapFrame) -> Int { self.size }

pub fn ImagetransformremapFrame::get(self : ImagetransformremapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapFrame::set(self : ImagetransformremapFrame, i : Int, v : Double) -> ImagetransformremapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapFrame::sum(self : ImagetransformremapFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapFrame::mean(self : ImagetransformremapFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapFrame::scale(self : ImagetransformremapFrame, f : Double) -> ImagetransformremapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapFrame::add(self : ImagetransformremapFrame, other : ImagetransformremapFrame) -> ImagetransformremapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapFrame::copy(self : ImagetransformremapFrame) -> ImagetransformremapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapFrame::fill(self : ImagetransformremapFrame, v : Double) -> ImagetransformremapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapFrame::min(self : ImagetransformremapFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapFrame::max(self : ImagetransformremapFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapFrame::to_string(self : ImagetransformremapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_table_make(size : Int) -> ImagetransformremapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapTable::len(self : ImagetransformremapTable) -> Int { self.size }

pub fn ImagetransformremapTable::get(self : ImagetransformremapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapTable::set(self : ImagetransformremapTable, i : Int, v : Double) -> ImagetransformremapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapTable::sum(self : ImagetransformremapTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapTable::mean(self : ImagetransformremapTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapTable::scale(self : ImagetransformremapTable, f : Double) -> ImagetransformremapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapTable::add(self : ImagetransformremapTable, other : ImagetransformremapTable) -> ImagetransformremapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapTable::copy(self : ImagetransformremapTable) -> ImagetransformremapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapTable::fill(self : ImagetransformremapTable, v : Double) -> ImagetransformremapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapTable::min(self : ImagetransformremapTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapTable::max(self : ImagetransformremapTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapTable::to_string(self : ImagetransformremapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_graphn_make(size : Int) -> ImagetransformremapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapGraphN::len(self : ImagetransformremapGraphN) -> Int { self.size }

pub fn ImagetransformremapGraphN::get(self : ImagetransformremapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapGraphN::set(self : ImagetransformremapGraphN, i : Int, v : Double) -> ImagetransformremapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapGraphN::sum(self : ImagetransformremapGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapGraphN::mean(self : ImagetransformremapGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapGraphN::scale(self : ImagetransformremapGraphN, f : Double) -> ImagetransformremapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapGraphN::add(self : ImagetransformremapGraphN, other : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapGraphN::copy(self : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapGraphN::fill(self : ImagetransformremapGraphN, v : Double) -> ImagetransformremapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapGraphN::min(self : ImagetransformremapGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapGraphN::max(self : ImagetransformremapGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapGraphN::to_string(self : ImagetransformremapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_node_make(size : Int) -> ImagetransformremapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapNode::len(self : ImagetransformremapNode) -> Int { self.size }

pub fn ImagetransformremapNode::get(self : ImagetransformremapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapNode::set(self : ImagetransformremapNode, i : Int, v : Double) -> ImagetransformremapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapNode::sum(self : ImagetransformremapNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapNode::mean(self : ImagetransformremapNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapNode::scale(self : ImagetransformremapNode, f : Double) -> ImagetransformremapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapNode::add(self : ImagetransformremapNode, other : ImagetransformremapNode) -> ImagetransformremapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapNode::copy(self : ImagetransformremapNode) -> ImagetransformremapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapNode::fill(self : ImagetransformremapNode, v : Double) -> ImagetransformremapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapNode::min(self : ImagetransformremapNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapNode::max(self : ImagetransformremapNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapNode::to_string(self : ImagetransformremapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_edge_make(size : Int) -> ImagetransformremapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapEdge::len(self : ImagetransformremapEdge) -> Int { self.size }

pub fn ImagetransformremapEdge::get(self : ImagetransformremapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapEdge::set(self : ImagetransformremapEdge, i : Int, v : Double) -> ImagetransformremapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapEdge::sum(self : ImagetransformremapEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapEdge::mean(self : ImagetransformremapEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapEdge::scale(self : ImagetransformremapEdge, f : Double) -> ImagetransformremapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapEdge::add(self : ImagetransformremapEdge, other : ImagetransformremapEdge) -> ImagetransformremapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapEdge::copy(self : ImagetransformremapEdge) -> ImagetransformremapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapEdge::fill(self : ImagetransformremapEdge, v : Double) -> ImagetransformremapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapEdge::min(self : ImagetransformremapEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapEdge::max(self : ImagetransformremapEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapEdge::to_string(self : ImagetransformremapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_path_make(size : Int) -> ImagetransformremapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapPath::len(self : ImagetransformremapPath) -> Int { self.size }

pub fn ImagetransformremapPath::get(self : ImagetransformremapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapPath::set(self : ImagetransformremapPath, i : Int, v : Double) -> ImagetransformremapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapPath::sum(self : ImagetransformremapPath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapPath::mean(self : ImagetransformremapPath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapPath::scale(self : ImagetransformremapPath, f : Double) -> ImagetransformremapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapPath::add(self : ImagetransformremapPath, other : ImagetransformremapPath) -> ImagetransformremapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapPath::copy(self : ImagetransformremapPath) -> ImagetransformremapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapPath::fill(self : ImagetransformremapPath, v : Double) -> ImagetransformremapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapPath::min(self : ImagetransformremapPath) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapPath::max(self : ImagetransformremapPath) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapPath::to_string(self : ImagetransformremapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cluster_make(size : Int) -> ImagetransformremapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapCluster::len(self : ImagetransformremapCluster) -> Int { self.size }

pub fn ImagetransformremapCluster::get(self : ImagetransformremapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapCluster::set(self : ImagetransformremapCluster, i : Int, v : Double) -> ImagetransformremapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCluster::sum(self : ImagetransformremapCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapCluster::mean(self : ImagetransformremapCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapCluster::scale(self : ImagetransformremapCluster, f : Double) -> ImagetransformremapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCluster::add(self : ImagetransformremapCluster, other : ImagetransformremapCluster) -> ImagetransformremapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapCluster::copy(self : ImagetransformremapCluster) -> ImagetransformremapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCluster::fill(self : ImagetransformremapCluster, v : Double) -> ImagetransformremapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCluster::min(self : ImagetransformremapCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapCluster::max(self : ImagetransformremapCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapCluster::to_string(self : ImagetransformremapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_model_make(size : Int) -> ImagetransformremapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapModel::len(self : ImagetransformremapModel) -> Int { self.size }

pub fn ImagetransformremapModel::get(self : ImagetransformremapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapModel::set(self : ImagetransformremapModel, i : Int, v : Double) -> ImagetransformremapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapModel::sum(self : ImagetransformremapModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapModel::mean(self : ImagetransformremapModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapModel::scale(self : ImagetransformremapModel, f : Double) -> ImagetransformremapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapModel::add(self : ImagetransformremapModel, other : ImagetransformremapModel) -> ImagetransformremapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapModel::copy(self : ImagetransformremapModel) -> ImagetransformremapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapModel::fill(self : ImagetransformremapModel, v : Double) -> ImagetransformremapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapModel::min(self : ImagetransformremapModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapModel::max(self : ImagetransformremapModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapModel::to_string(self : ImagetransformremapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_layer_make(size : Int) -> ImagetransformremapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapLayer::len(self : ImagetransformremapLayer) -> Int { self.size }

pub fn ImagetransformremapLayer::get(self : ImagetransformremapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapLayer::set(self : ImagetransformremapLayer, i : Int, v : Double) -> ImagetransformremapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapLayer::sum(self : ImagetransformremapLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapLayer::mean(self : ImagetransformremapLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapLayer::scale(self : ImagetransformremapLayer, f : Double) -> ImagetransformremapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapLayer::add(self : ImagetransformremapLayer, other : ImagetransformremapLayer) -> ImagetransformremapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapLayer::copy(self : ImagetransformremapLayer) -> ImagetransformremapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapLayer::fill(self : ImagetransformremapLayer, v : Double) -> ImagetransformremapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapLayer::min(self : ImagetransformremapLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapLayer::max(self : ImagetransformremapLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapLayer::to_string(self : ImagetransformremapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_buffer_make(size : Int) -> ImagetransformremapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapBuffer::len(self : ImagetransformremapBuffer) -> Int { self.size }

pub fn ImagetransformremapBuffer::get(self : ImagetransformremapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapBuffer::set(self : ImagetransformremapBuffer, i : Int, v : Double) -> ImagetransformremapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapBuffer::sum(self : ImagetransformremapBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapBuffer::mean(self : ImagetransformremapBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapBuffer::scale(self : ImagetransformremapBuffer, f : Double) -> ImagetransformremapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapBuffer::add(self : ImagetransformremapBuffer, other : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapBuffer::copy(self : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapBuffer::fill(self : ImagetransformremapBuffer, v : Double) -> ImagetransformremapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapBuffer::min(self : ImagetransformremapBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapBuffer::max(self : ImagetransformremapBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapBuffer::to_string(self : ImagetransformremapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cursor_make(size : Int) -> ImagetransformremapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapCursor::len(self : ImagetransformremapCursor) -> Int { self.size }

pub fn ImagetransformremapCursor::get(self : ImagetransformremapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapCursor::set(self : ImagetransformremapCursor, i : Int, v : Double) -> ImagetransformremapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCursor::sum(self : ImagetransformremapCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapCursor::mean(self : ImagetransformremapCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapCursor::scale(self : ImagetransformremapCursor, f : Double) -> ImagetransformremapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCursor::add(self : ImagetransformremapCursor, other : ImagetransformremapCursor) -> ImagetransformremapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapCursor::copy(self : ImagetransformremapCursor) -> ImagetransformremapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCursor::fill(self : ImagetransformremapCursor, v : Double) -> ImagetransformremapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapCursor::min(self : ImagetransformremapCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapCursor::max(self : ImagetransformremapCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapCursor::to_string(self : ImagetransformremapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_view_make(size : Int) -> ImagetransformremapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapView::len(self : ImagetransformremapView) -> Int { self.size }

pub fn ImagetransformremapView::get(self : ImagetransformremapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapView::set(self : ImagetransformremapView, i : Int, v : Double) -> ImagetransformremapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapView::sum(self : ImagetransformremapView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapView::mean(self : ImagetransformremapView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapView::scale(self : ImagetransformremapView, f : Double) -> ImagetransformremapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapView::add(self : ImagetransformremapView, other : ImagetransformremapView) -> ImagetransformremapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapView::copy(self : ImagetransformremapView) -> ImagetransformremapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapView::fill(self : ImagetransformremapView, v : Double) -> ImagetransformremapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapView::min(self : ImagetransformremapView) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapView::max(self : ImagetransformremapView) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapView::to_string(self : ImagetransformremapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_range_make(size : Int) -> ImagetransformremapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapRange::len(self : ImagetransformremapRange) -> Int { self.size }

pub fn ImagetransformremapRange::get(self : ImagetransformremapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapRange::set(self : ImagetransformremapRange, i : Int, v : Double) -> ImagetransformremapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapRange::sum(self : ImagetransformremapRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapRange::mean(self : ImagetransformremapRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapRange::scale(self : ImagetransformremapRange, f : Double) -> ImagetransformremapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapRange::add(self : ImagetransformremapRange, other : ImagetransformremapRange) -> ImagetransformremapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapRange::copy(self : ImagetransformremapRange) -> ImagetransformremapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapRange::fill(self : ImagetransformremapRange, v : Double) -> ImagetransformremapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapRange::min(self : ImagetransformremapRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapRange::max(self : ImagetransformremapRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapRange::to_string(self : ImagetransformremapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_slice_make(size : Int) -> ImagetransformremapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformremapSlice::len(self : ImagetransformremapSlice) -> Int { self.size }

pub fn ImagetransformremapSlice::get(self : ImagetransformremapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformremapSlice::set(self : ImagetransformremapSlice, i : Int, v : Double) -> ImagetransformremapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformremapSlice::sum(self : ImagetransformremapSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformremapSlice::mean(self : ImagetransformremapSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformremapSlice::scale(self : ImagetransformremapSlice, f : Double) -> ImagetransformremapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapSlice::add(self : ImagetransformremapSlice, other : ImagetransformremapSlice) -> ImagetransformremapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformremapSlice::copy(self : ImagetransformremapSlice) -> ImagetransformremapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapSlice::fill(self : ImagetransformremapSlice, v : Double) -> ImagetransformremapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformremapSlice::min(self : ImagetransformremapSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformremapSlice::max(self : ImagetransformremapSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformremapSlice::to_string(self : ImagetransformremapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

