///===
/// extcore/image_morph_close

pub(all) struct ImagemorphclosePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_close_make_point(x : Double, y : Double) -> ImagemorphclosePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_close_make_point3(x : Double, y : Double, z : Double) -> ImagemorphclosePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphclosePoint::x(self : ImagemorphclosePoint) -> Double { self.x }

pub fn ImagemorphclosePoint::y(self : ImagemorphclosePoint) -> Double { self.y }

pub fn ImagemorphclosePoint::z(self : ImagemorphclosePoint) -> Double { self.z }

pub fn ImagemorphclosePoint::label(self : ImagemorphclosePoint) -> Int { self.label }

pub fn ImagemorphclosePoint::dist(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphclosePoint::add(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphclosePoint::sub(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphclosePoint::scale(self : ImagemorphclosePoint, s : Double) -> ImagemorphclosePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphclosePoint::dot(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphclosePoint::cross(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphclosePoint::norm(self : ImagemorphclosePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphclosePoint::normalize(self : ImagemorphclosePoint) -> ImagemorphclosePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphclosePoint::negate(self : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphclosePoint::mid(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphclosePoint::lerp(self : ImagemorphclosePoint, other : ImagemorphclosePoint, t : Double) -> ImagemorphclosePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphclosePoint::to_string(self : ImagemorphclosePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphcloseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_close_make_series(vals : Array[Double], name : String) -> ImagemorphcloseSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphcloseSeries::len(self : ImagemorphcloseSeries) -> Int { self.vals.length() }

pub fn ImagemorphcloseSeries::sum(self : ImagemorphcloseSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphcloseSeries::mean(self : ImagemorphcloseSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphcloseSeries::min(self : ImagemorphcloseSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphcloseSeries::max(self : ImagemorphcloseSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphcloseSeries::range(self : ImagemorphcloseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphcloseSeries::variance(self : ImagemorphcloseSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphcloseSeries::std(self : ImagemorphcloseSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphcloseSeries::median(self : ImagemorphcloseSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphcloseSeries::scale(self : ImagemorphcloseSeries, f : Double) -> ImagemorphcloseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::add(self : ImagemorphcloseSeries, other : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::sub(self : ImagemorphcloseSeries, other : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::normalize(self : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphcloseSeries::cumsum(self : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphcloseSeries::to_string(self : ImagemorphcloseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphcloseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_close_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphcloseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_close_matrix_identity(n : Int) -> ImagemorphcloseMatrix {
  let m = image_morph_close_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphcloseMatrix::get(self : ImagemorphcloseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphcloseMatrix::transpose(self : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphcloseMatrix::add(self : ImagemorphcloseMatrix, other : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_close_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphcloseMatrix::scale(self : ImagemorphcloseMatrix, s : Double) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphcloseMatrix::multiply(self : ImagemorphcloseMatrix, other : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if self.cols != other.rows { return image_morph_close_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_close_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagemorphcloseMatrix::trace(self : ImagemorphcloseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphcloseMatrix::det(self : ImagemorphcloseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphcloseMatrix::norm(self : ImagemorphcloseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphcloseMatrix::to_string(self : ImagemorphcloseMatrix) -> String {
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

pub(all) struct ImagemorphcloseVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_close_make_vector(comps : Array[Double]) -> ImagemorphcloseVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_close_vector_zero(dim : Int) -> ImagemorphcloseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphcloseVector::add(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphcloseVector::sub(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphcloseVector::scale(self : ImagemorphcloseVector, s : Double) -> ImagemorphcloseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphcloseVector::dot(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphcloseVector::norm(self : ImagemorphcloseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphcloseVector::normalize(self : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphcloseVector::dist(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphcloseVector::to_string(self : ImagemorphcloseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphcloseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_frame_make(size : Int) -> ImagemorphcloseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseFrame::len(self : ImagemorphcloseFrame) -> Int { self.size }

pub fn ImagemorphcloseFrame::get(self : ImagemorphcloseFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseFrame::set(self : ImagemorphcloseFrame, i : Int, v : Double) -> ImagemorphcloseFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseFrame::sum(self : ImagemorphcloseFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseFrame::mean(self : ImagemorphcloseFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseFrame::scale(self : ImagemorphcloseFrame, f : Double) -> ImagemorphcloseFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseFrame::add(self : ImagemorphcloseFrame, other : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseFrame::copy(self : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseFrame::fill(self : ImagemorphcloseFrame, v : Double) -> ImagemorphcloseFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseFrame::min(self : ImagemorphcloseFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseFrame::max(self : ImagemorphcloseFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseFrame::to_string(self : ImagemorphcloseFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_table_make(size : Int) -> ImagemorphcloseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseTable::len(self : ImagemorphcloseTable) -> Int { self.size }

pub fn ImagemorphcloseTable::get(self : ImagemorphcloseTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseTable::set(self : ImagemorphcloseTable, i : Int, v : Double) -> ImagemorphcloseTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseTable::sum(self : ImagemorphcloseTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseTable::mean(self : ImagemorphcloseTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseTable::scale(self : ImagemorphcloseTable, f : Double) -> ImagemorphcloseTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseTable::add(self : ImagemorphcloseTable, other : ImagemorphcloseTable) -> ImagemorphcloseTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseTable::copy(self : ImagemorphcloseTable) -> ImagemorphcloseTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseTable::fill(self : ImagemorphcloseTable, v : Double) -> ImagemorphcloseTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseTable::min(self : ImagemorphcloseTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseTable::max(self : ImagemorphcloseTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseTable::to_string(self : ImagemorphcloseTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_graphn_make(size : Int) -> ImagemorphcloseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseGraphN::len(self : ImagemorphcloseGraphN) -> Int { self.size }

pub fn ImagemorphcloseGraphN::get(self : ImagemorphcloseGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseGraphN::set(self : ImagemorphcloseGraphN, i : Int, v : Double) -> ImagemorphcloseGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseGraphN::sum(self : ImagemorphcloseGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseGraphN::mean(self : ImagemorphcloseGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseGraphN::scale(self : ImagemorphcloseGraphN, f : Double) -> ImagemorphcloseGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseGraphN::add(self : ImagemorphcloseGraphN, other : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseGraphN::copy(self : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseGraphN::fill(self : ImagemorphcloseGraphN, v : Double) -> ImagemorphcloseGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseGraphN::min(self : ImagemorphcloseGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseGraphN::max(self : ImagemorphcloseGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseGraphN::to_string(self : ImagemorphcloseGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_node_make(size : Int) -> ImagemorphcloseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseNode::len(self : ImagemorphcloseNode) -> Int { self.size }

pub fn ImagemorphcloseNode::get(self : ImagemorphcloseNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseNode::set(self : ImagemorphcloseNode, i : Int, v : Double) -> ImagemorphcloseNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseNode::sum(self : ImagemorphcloseNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseNode::mean(self : ImagemorphcloseNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseNode::scale(self : ImagemorphcloseNode, f : Double) -> ImagemorphcloseNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseNode::add(self : ImagemorphcloseNode, other : ImagemorphcloseNode) -> ImagemorphcloseNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseNode::copy(self : ImagemorphcloseNode) -> ImagemorphcloseNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseNode::fill(self : ImagemorphcloseNode, v : Double) -> ImagemorphcloseNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseNode::min(self : ImagemorphcloseNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseNode::max(self : ImagemorphcloseNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseNode::to_string(self : ImagemorphcloseNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_edge_make(size : Int) -> ImagemorphcloseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseEdge::len(self : ImagemorphcloseEdge) -> Int { self.size }

pub fn ImagemorphcloseEdge::get(self : ImagemorphcloseEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseEdge::set(self : ImagemorphcloseEdge, i : Int, v : Double) -> ImagemorphcloseEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseEdge::sum(self : ImagemorphcloseEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseEdge::mean(self : ImagemorphcloseEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseEdge::scale(self : ImagemorphcloseEdge, f : Double) -> ImagemorphcloseEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseEdge::add(self : ImagemorphcloseEdge, other : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseEdge::copy(self : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseEdge::fill(self : ImagemorphcloseEdge, v : Double) -> ImagemorphcloseEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseEdge::min(self : ImagemorphcloseEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseEdge::max(self : ImagemorphcloseEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseEdge::to_string(self : ImagemorphcloseEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphclosePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_path_make(size : Int) -> ImagemorphclosePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphclosePath::len(self : ImagemorphclosePath) -> Int { self.size }

pub fn ImagemorphclosePath::get(self : ImagemorphclosePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphclosePath::set(self : ImagemorphclosePath, i : Int, v : Double) -> ImagemorphclosePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphclosePath::sum(self : ImagemorphclosePath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphclosePath::mean(self : ImagemorphclosePath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphclosePath::scale(self : ImagemorphclosePath, f : Double) -> ImagemorphclosePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphclosePath::add(self : ImagemorphclosePath, other : ImagemorphclosePath) -> ImagemorphclosePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphclosePath::copy(self : ImagemorphclosePath) -> ImagemorphclosePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphclosePath::fill(self : ImagemorphclosePath, v : Double) -> ImagemorphclosePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphclosePath::min(self : ImagemorphclosePath) -> Double { @_common.min(self.data) }

pub fn ImagemorphclosePath::max(self : ImagemorphclosePath) -> Double { @_common.max(self.data) }

pub fn ImagemorphclosePath::to_string(self : ImagemorphclosePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cluster_make(size : Int) -> ImagemorphcloseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseCluster::len(self : ImagemorphcloseCluster) -> Int { self.size }

pub fn ImagemorphcloseCluster::get(self : ImagemorphcloseCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseCluster::set(self : ImagemorphcloseCluster, i : Int, v : Double) -> ImagemorphcloseCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCluster::sum(self : ImagemorphcloseCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseCluster::mean(self : ImagemorphcloseCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseCluster::scale(self : ImagemorphcloseCluster, f : Double) -> ImagemorphcloseCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCluster::add(self : ImagemorphcloseCluster, other : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseCluster::copy(self : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCluster::fill(self : ImagemorphcloseCluster, v : Double) -> ImagemorphcloseCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCluster::min(self : ImagemorphcloseCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseCluster::max(self : ImagemorphcloseCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseCluster::to_string(self : ImagemorphcloseCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_model_make(size : Int) -> ImagemorphcloseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseModel::len(self : ImagemorphcloseModel) -> Int { self.size }

pub fn ImagemorphcloseModel::get(self : ImagemorphcloseModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseModel::set(self : ImagemorphcloseModel, i : Int, v : Double) -> ImagemorphcloseModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseModel::sum(self : ImagemorphcloseModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseModel::mean(self : ImagemorphcloseModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseModel::scale(self : ImagemorphcloseModel, f : Double) -> ImagemorphcloseModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseModel::add(self : ImagemorphcloseModel, other : ImagemorphcloseModel) -> ImagemorphcloseModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseModel::copy(self : ImagemorphcloseModel) -> ImagemorphcloseModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseModel::fill(self : ImagemorphcloseModel, v : Double) -> ImagemorphcloseModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseModel::min(self : ImagemorphcloseModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseModel::max(self : ImagemorphcloseModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseModel::to_string(self : ImagemorphcloseModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_layer_make(size : Int) -> ImagemorphcloseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseLayer::len(self : ImagemorphcloseLayer) -> Int { self.size }

pub fn ImagemorphcloseLayer::get(self : ImagemorphcloseLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseLayer::set(self : ImagemorphcloseLayer, i : Int, v : Double) -> ImagemorphcloseLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseLayer::sum(self : ImagemorphcloseLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseLayer::mean(self : ImagemorphcloseLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseLayer::scale(self : ImagemorphcloseLayer, f : Double) -> ImagemorphcloseLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseLayer::add(self : ImagemorphcloseLayer, other : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseLayer::copy(self : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseLayer::fill(self : ImagemorphcloseLayer, v : Double) -> ImagemorphcloseLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseLayer::min(self : ImagemorphcloseLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseLayer::max(self : ImagemorphcloseLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseLayer::to_string(self : ImagemorphcloseLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_buffer_make(size : Int) -> ImagemorphcloseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseBuffer::len(self : ImagemorphcloseBuffer) -> Int { self.size }

pub fn ImagemorphcloseBuffer::get(self : ImagemorphcloseBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseBuffer::set(self : ImagemorphcloseBuffer, i : Int, v : Double) -> ImagemorphcloseBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseBuffer::sum(self : ImagemorphcloseBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseBuffer::mean(self : ImagemorphcloseBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseBuffer::scale(self : ImagemorphcloseBuffer, f : Double) -> ImagemorphcloseBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseBuffer::add(self : ImagemorphcloseBuffer, other : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseBuffer::copy(self : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseBuffer::fill(self : ImagemorphcloseBuffer, v : Double) -> ImagemorphcloseBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseBuffer::min(self : ImagemorphcloseBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseBuffer::max(self : ImagemorphcloseBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseBuffer::to_string(self : ImagemorphcloseBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cursor_make(size : Int) -> ImagemorphcloseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseCursor::len(self : ImagemorphcloseCursor) -> Int { self.size }

pub fn ImagemorphcloseCursor::get(self : ImagemorphcloseCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseCursor::set(self : ImagemorphcloseCursor, i : Int, v : Double) -> ImagemorphcloseCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCursor::sum(self : ImagemorphcloseCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseCursor::mean(self : ImagemorphcloseCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseCursor::scale(self : ImagemorphcloseCursor, f : Double) -> ImagemorphcloseCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCursor::add(self : ImagemorphcloseCursor, other : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseCursor::copy(self : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCursor::fill(self : ImagemorphcloseCursor, v : Double) -> ImagemorphcloseCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseCursor::min(self : ImagemorphcloseCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseCursor::max(self : ImagemorphcloseCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseCursor::to_string(self : ImagemorphcloseCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_view_make(size : Int) -> ImagemorphcloseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseView::len(self : ImagemorphcloseView) -> Int { self.size }

pub fn ImagemorphcloseView::get(self : ImagemorphcloseView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseView::set(self : ImagemorphcloseView, i : Int, v : Double) -> ImagemorphcloseView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseView::sum(self : ImagemorphcloseView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseView::mean(self : ImagemorphcloseView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseView::scale(self : ImagemorphcloseView, f : Double) -> ImagemorphcloseView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseView::add(self : ImagemorphcloseView, other : ImagemorphcloseView) -> ImagemorphcloseView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseView::copy(self : ImagemorphcloseView) -> ImagemorphcloseView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseView::fill(self : ImagemorphcloseView, v : Double) -> ImagemorphcloseView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseView::min(self : ImagemorphcloseView) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseView::max(self : ImagemorphcloseView) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseView::to_string(self : ImagemorphcloseView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_range_make(size : Int) -> ImagemorphcloseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseRange::len(self : ImagemorphcloseRange) -> Int { self.size }

pub fn ImagemorphcloseRange::get(self : ImagemorphcloseRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseRange::set(self : ImagemorphcloseRange, i : Int, v : Double) -> ImagemorphcloseRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseRange::sum(self : ImagemorphcloseRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseRange::mean(self : ImagemorphcloseRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseRange::scale(self : ImagemorphcloseRange, f : Double) -> ImagemorphcloseRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseRange::add(self : ImagemorphcloseRange, other : ImagemorphcloseRange) -> ImagemorphcloseRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseRange::copy(self : ImagemorphcloseRange) -> ImagemorphcloseRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseRange::fill(self : ImagemorphcloseRange, v : Double) -> ImagemorphcloseRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseRange::min(self : ImagemorphcloseRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseRange::max(self : ImagemorphcloseRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseRange::to_string(self : ImagemorphcloseRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_slice_make(size : Int) -> ImagemorphcloseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphcloseSlice::len(self : ImagemorphcloseSlice) -> Int { self.size }

pub fn ImagemorphcloseSlice::get(self : ImagemorphcloseSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphcloseSlice::set(self : ImagemorphcloseSlice, i : Int, v : Double) -> ImagemorphcloseSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseSlice::sum(self : ImagemorphcloseSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphcloseSlice::mean(self : ImagemorphcloseSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphcloseSlice::scale(self : ImagemorphcloseSlice, f : Double) -> ImagemorphcloseSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseSlice::add(self : ImagemorphcloseSlice, other : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphcloseSlice::copy(self : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseSlice::fill(self : ImagemorphcloseSlice, v : Double) -> ImagemorphcloseSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphcloseSlice::min(self : ImagemorphcloseSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphcloseSlice::max(self : ImagemorphcloseSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphcloseSlice::to_string(self : ImagemorphcloseSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

