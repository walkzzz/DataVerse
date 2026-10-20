///===
/// extcore/image_morph_dilate

pub(all) struct ImagemorphdilatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_dilate_make_point(x : Double, y : Double) -> ImagemorphdilatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_dilate_make_point3(x : Double, y : Double, z : Double) -> ImagemorphdilatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphdilatePoint::x(self : ImagemorphdilatePoint) -> Double { self.x }

pub fn ImagemorphdilatePoint::y(self : ImagemorphdilatePoint) -> Double { self.y }

pub fn ImagemorphdilatePoint::z(self : ImagemorphdilatePoint) -> Double { self.z }

pub fn ImagemorphdilatePoint::label(self : ImagemorphdilatePoint) -> Int { self.label }

pub fn ImagemorphdilatePoint::dist(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphdilatePoint::add(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphdilatePoint::sub(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphdilatePoint::scale(self : ImagemorphdilatePoint, s : Double) -> ImagemorphdilatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphdilatePoint::dot(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphdilatePoint::cross(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphdilatePoint::norm(self : ImagemorphdilatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphdilatePoint::normalize(self : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphdilatePoint::negate(self : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphdilatePoint::mid(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphdilatePoint::lerp(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint, t : Double) -> ImagemorphdilatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphdilatePoint::to_string(self : ImagemorphdilatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphdilateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_dilate_make_series(vals : Array[Double], name : String) -> ImagemorphdilateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphdilateSeries::len(self : ImagemorphdilateSeries) -> Int { self.vals.length() }

pub fn ImagemorphdilateSeries::sum(self : ImagemorphdilateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphdilateSeries::mean(self : ImagemorphdilateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphdilateSeries::min(self : ImagemorphdilateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphdilateSeries::max(self : ImagemorphdilateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphdilateSeries::range(self : ImagemorphdilateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphdilateSeries::variance(self : ImagemorphdilateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphdilateSeries::std(self : ImagemorphdilateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphdilateSeries::median(self : ImagemorphdilateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphdilateSeries::scale(self : ImagemorphdilateSeries, f : Double) -> ImagemorphdilateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::add(self : ImagemorphdilateSeries, other : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::sub(self : ImagemorphdilateSeries, other : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::normalize(self : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphdilateSeries::cumsum(self : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphdilateSeries::to_string(self : ImagemorphdilateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphdilateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_dilate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphdilateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_dilate_matrix_identity(n : Int) -> ImagemorphdilateMatrix {
  let m = image_morph_dilate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphdilateMatrix::get(self : ImagemorphdilateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphdilateMatrix::transpose(self : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphdilateMatrix::add(self : ImagemorphdilateMatrix, other : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_dilate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphdilateMatrix::scale(self : ImagemorphdilateMatrix, s : Double) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphdilateMatrix::multiply(self : ImagemorphdilateMatrix, other : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if self.cols != other.rows { return image_morph_dilate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_dilate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphdilateMatrix::trace(self : ImagemorphdilateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphdilateMatrix::det(self : ImagemorphdilateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphdilateMatrix::norm(self : ImagemorphdilateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphdilateMatrix::to_string(self : ImagemorphdilateMatrix) -> String {
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

pub(all) struct ImagemorphdilateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_dilate_make_vector(comps : Array[Double]) -> ImagemorphdilateVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_dilate_vector_zero(dim : Int) -> ImagemorphdilateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphdilateVector::add(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphdilateVector::sub(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphdilateVector::scale(self : ImagemorphdilateVector, s : Double) -> ImagemorphdilateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphdilateVector::dot(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphdilateVector::norm(self : ImagemorphdilateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphdilateVector::normalize(self : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphdilateVector::dist(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphdilateVector::to_string(self : ImagemorphdilateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphdilateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_frame_make(size : Int) -> ImagemorphdilateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateFrame::len(self : ImagemorphdilateFrame) -> Int { self.size }

pub fn ImagemorphdilateFrame::get(self : ImagemorphdilateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateFrame::set(self : ImagemorphdilateFrame, i : Int, v : Double) -> ImagemorphdilateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateFrame::sum(self : ImagemorphdilateFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateFrame::mean(self : ImagemorphdilateFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateFrame::scale(self : ImagemorphdilateFrame, f : Double) -> ImagemorphdilateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateFrame::add(self : ImagemorphdilateFrame, other : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateFrame::copy(self : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateFrame::fill(self : ImagemorphdilateFrame, v : Double) -> ImagemorphdilateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateFrame::min(self : ImagemorphdilateFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateFrame::max(self : ImagemorphdilateFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateFrame::to_string(self : ImagemorphdilateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_table_make(size : Int) -> ImagemorphdilateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateTable::len(self : ImagemorphdilateTable) -> Int { self.size }

pub fn ImagemorphdilateTable::get(self : ImagemorphdilateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateTable::set(self : ImagemorphdilateTable, i : Int, v : Double) -> ImagemorphdilateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateTable::sum(self : ImagemorphdilateTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateTable::mean(self : ImagemorphdilateTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateTable::scale(self : ImagemorphdilateTable, f : Double) -> ImagemorphdilateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateTable::add(self : ImagemorphdilateTable, other : ImagemorphdilateTable) -> ImagemorphdilateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateTable::copy(self : ImagemorphdilateTable) -> ImagemorphdilateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateTable::fill(self : ImagemorphdilateTable, v : Double) -> ImagemorphdilateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateTable::min(self : ImagemorphdilateTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateTable::max(self : ImagemorphdilateTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateTable::to_string(self : ImagemorphdilateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_graphn_make(size : Int) -> ImagemorphdilateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateGraphN::len(self : ImagemorphdilateGraphN) -> Int { self.size }

pub fn ImagemorphdilateGraphN::get(self : ImagemorphdilateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateGraphN::set(self : ImagemorphdilateGraphN, i : Int, v : Double) -> ImagemorphdilateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateGraphN::sum(self : ImagemorphdilateGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateGraphN::mean(self : ImagemorphdilateGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateGraphN::scale(self : ImagemorphdilateGraphN, f : Double) -> ImagemorphdilateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateGraphN::add(self : ImagemorphdilateGraphN, other : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateGraphN::copy(self : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateGraphN::fill(self : ImagemorphdilateGraphN, v : Double) -> ImagemorphdilateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateGraphN::min(self : ImagemorphdilateGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateGraphN::max(self : ImagemorphdilateGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateGraphN::to_string(self : ImagemorphdilateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_node_make(size : Int) -> ImagemorphdilateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateNode::len(self : ImagemorphdilateNode) -> Int { self.size }

pub fn ImagemorphdilateNode::get(self : ImagemorphdilateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateNode::set(self : ImagemorphdilateNode, i : Int, v : Double) -> ImagemorphdilateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateNode::sum(self : ImagemorphdilateNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateNode::mean(self : ImagemorphdilateNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateNode::scale(self : ImagemorphdilateNode, f : Double) -> ImagemorphdilateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateNode::add(self : ImagemorphdilateNode, other : ImagemorphdilateNode) -> ImagemorphdilateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateNode::copy(self : ImagemorphdilateNode) -> ImagemorphdilateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateNode::fill(self : ImagemorphdilateNode, v : Double) -> ImagemorphdilateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateNode::min(self : ImagemorphdilateNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateNode::max(self : ImagemorphdilateNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateNode::to_string(self : ImagemorphdilateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_edge_make(size : Int) -> ImagemorphdilateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateEdge::len(self : ImagemorphdilateEdge) -> Int { self.size }

pub fn ImagemorphdilateEdge::get(self : ImagemorphdilateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateEdge::set(self : ImagemorphdilateEdge, i : Int, v : Double) -> ImagemorphdilateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateEdge::sum(self : ImagemorphdilateEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateEdge::mean(self : ImagemorphdilateEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateEdge::scale(self : ImagemorphdilateEdge, f : Double) -> ImagemorphdilateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateEdge::add(self : ImagemorphdilateEdge, other : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateEdge::copy(self : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateEdge::fill(self : ImagemorphdilateEdge, v : Double) -> ImagemorphdilateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateEdge::min(self : ImagemorphdilateEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateEdge::max(self : ImagemorphdilateEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateEdge::to_string(self : ImagemorphdilateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_path_make(size : Int) -> ImagemorphdilatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilatePath::len(self : ImagemorphdilatePath) -> Int { self.size }

pub fn ImagemorphdilatePath::get(self : ImagemorphdilatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilatePath::set(self : ImagemorphdilatePath, i : Int, v : Double) -> ImagemorphdilatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilatePath::sum(self : ImagemorphdilatePath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilatePath::mean(self : ImagemorphdilatePath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilatePath::scale(self : ImagemorphdilatePath, f : Double) -> ImagemorphdilatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilatePath::add(self : ImagemorphdilatePath, other : ImagemorphdilatePath) -> ImagemorphdilatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilatePath::copy(self : ImagemorphdilatePath) -> ImagemorphdilatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilatePath::fill(self : ImagemorphdilatePath, v : Double) -> ImagemorphdilatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilatePath::min(self : ImagemorphdilatePath) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilatePath::max(self : ImagemorphdilatePath) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilatePath::to_string(self : ImagemorphdilatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cluster_make(size : Int) -> ImagemorphdilateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateCluster::len(self : ImagemorphdilateCluster) -> Int { self.size }

pub fn ImagemorphdilateCluster::get(self : ImagemorphdilateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateCluster::set(self : ImagemorphdilateCluster, i : Int, v : Double) -> ImagemorphdilateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCluster::sum(self : ImagemorphdilateCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateCluster::mean(self : ImagemorphdilateCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateCluster::scale(self : ImagemorphdilateCluster, f : Double) -> ImagemorphdilateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCluster::add(self : ImagemorphdilateCluster, other : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateCluster::copy(self : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCluster::fill(self : ImagemorphdilateCluster, v : Double) -> ImagemorphdilateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCluster::min(self : ImagemorphdilateCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateCluster::max(self : ImagemorphdilateCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateCluster::to_string(self : ImagemorphdilateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_model_make(size : Int) -> ImagemorphdilateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateModel::len(self : ImagemorphdilateModel) -> Int { self.size }

pub fn ImagemorphdilateModel::get(self : ImagemorphdilateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateModel::set(self : ImagemorphdilateModel, i : Int, v : Double) -> ImagemorphdilateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateModel::sum(self : ImagemorphdilateModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateModel::mean(self : ImagemorphdilateModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateModel::scale(self : ImagemorphdilateModel, f : Double) -> ImagemorphdilateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateModel::add(self : ImagemorphdilateModel, other : ImagemorphdilateModel) -> ImagemorphdilateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateModel::copy(self : ImagemorphdilateModel) -> ImagemorphdilateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateModel::fill(self : ImagemorphdilateModel, v : Double) -> ImagemorphdilateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateModel::min(self : ImagemorphdilateModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateModel::max(self : ImagemorphdilateModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateModel::to_string(self : ImagemorphdilateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_layer_make(size : Int) -> ImagemorphdilateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateLayer::len(self : ImagemorphdilateLayer) -> Int { self.size }

pub fn ImagemorphdilateLayer::get(self : ImagemorphdilateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateLayer::set(self : ImagemorphdilateLayer, i : Int, v : Double) -> ImagemorphdilateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateLayer::sum(self : ImagemorphdilateLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateLayer::mean(self : ImagemorphdilateLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateLayer::scale(self : ImagemorphdilateLayer, f : Double) -> ImagemorphdilateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateLayer::add(self : ImagemorphdilateLayer, other : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateLayer::copy(self : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateLayer::fill(self : ImagemorphdilateLayer, v : Double) -> ImagemorphdilateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateLayer::min(self : ImagemorphdilateLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateLayer::max(self : ImagemorphdilateLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateLayer::to_string(self : ImagemorphdilateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_buffer_make(size : Int) -> ImagemorphdilateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateBuffer::len(self : ImagemorphdilateBuffer) -> Int { self.size }

pub fn ImagemorphdilateBuffer::get(self : ImagemorphdilateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateBuffer::set(self : ImagemorphdilateBuffer, i : Int, v : Double) -> ImagemorphdilateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateBuffer::sum(self : ImagemorphdilateBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateBuffer::mean(self : ImagemorphdilateBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateBuffer::scale(self : ImagemorphdilateBuffer, f : Double) -> ImagemorphdilateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateBuffer::add(self : ImagemorphdilateBuffer, other : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateBuffer::copy(self : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateBuffer::fill(self : ImagemorphdilateBuffer, v : Double) -> ImagemorphdilateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateBuffer::min(self : ImagemorphdilateBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateBuffer::max(self : ImagemorphdilateBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateBuffer::to_string(self : ImagemorphdilateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cursor_make(size : Int) -> ImagemorphdilateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateCursor::len(self : ImagemorphdilateCursor) -> Int { self.size }

pub fn ImagemorphdilateCursor::get(self : ImagemorphdilateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateCursor::set(self : ImagemorphdilateCursor, i : Int, v : Double) -> ImagemorphdilateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCursor::sum(self : ImagemorphdilateCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateCursor::mean(self : ImagemorphdilateCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateCursor::scale(self : ImagemorphdilateCursor, f : Double) -> ImagemorphdilateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCursor::add(self : ImagemorphdilateCursor, other : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateCursor::copy(self : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCursor::fill(self : ImagemorphdilateCursor, v : Double) -> ImagemorphdilateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateCursor::min(self : ImagemorphdilateCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateCursor::max(self : ImagemorphdilateCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateCursor::to_string(self : ImagemorphdilateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_view_make(size : Int) -> ImagemorphdilateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateView::len(self : ImagemorphdilateView) -> Int { self.size }

pub fn ImagemorphdilateView::get(self : ImagemorphdilateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateView::set(self : ImagemorphdilateView, i : Int, v : Double) -> ImagemorphdilateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateView::sum(self : ImagemorphdilateView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateView::mean(self : ImagemorphdilateView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateView::scale(self : ImagemorphdilateView, f : Double) -> ImagemorphdilateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateView::add(self : ImagemorphdilateView, other : ImagemorphdilateView) -> ImagemorphdilateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateView::copy(self : ImagemorphdilateView) -> ImagemorphdilateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateView::fill(self : ImagemorphdilateView, v : Double) -> ImagemorphdilateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateView::min(self : ImagemorphdilateView) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateView::max(self : ImagemorphdilateView) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateView::to_string(self : ImagemorphdilateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_range_make(size : Int) -> ImagemorphdilateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateRange::len(self : ImagemorphdilateRange) -> Int { self.size }

pub fn ImagemorphdilateRange::get(self : ImagemorphdilateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateRange::set(self : ImagemorphdilateRange, i : Int, v : Double) -> ImagemorphdilateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateRange::sum(self : ImagemorphdilateRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateRange::mean(self : ImagemorphdilateRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateRange::scale(self : ImagemorphdilateRange, f : Double) -> ImagemorphdilateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateRange::add(self : ImagemorphdilateRange, other : ImagemorphdilateRange) -> ImagemorphdilateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateRange::copy(self : ImagemorphdilateRange) -> ImagemorphdilateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateRange::fill(self : ImagemorphdilateRange, v : Double) -> ImagemorphdilateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateRange::min(self : ImagemorphdilateRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateRange::max(self : ImagemorphdilateRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateRange::to_string(self : ImagemorphdilateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_slice_make(size : Int) -> ImagemorphdilateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphdilateSlice::len(self : ImagemorphdilateSlice) -> Int { self.size }

pub fn ImagemorphdilateSlice::get(self : ImagemorphdilateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphdilateSlice::set(self : ImagemorphdilateSlice, i : Int, v : Double) -> ImagemorphdilateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateSlice::sum(self : ImagemorphdilateSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphdilateSlice::mean(self : ImagemorphdilateSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphdilateSlice::scale(self : ImagemorphdilateSlice, f : Double) -> ImagemorphdilateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateSlice::add(self : ImagemorphdilateSlice, other : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphdilateSlice::copy(self : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateSlice::fill(self : ImagemorphdilateSlice, v : Double) -> ImagemorphdilateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphdilateSlice::min(self : ImagemorphdilateSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphdilateSlice::max(self : ImagemorphdilateSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphdilateSlice::to_string(self : ImagemorphdilateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

