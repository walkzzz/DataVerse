///===
/// extcore/image_morph_open

pub(all) struct ImagemorphopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_open_make_point(x : Double, y : Double) -> ImagemorphopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_open_make_point3(x : Double, y : Double, z : Double) -> ImagemorphopenPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphopenPoint::x(self : ImagemorphopenPoint) -> Double { self.x }

pub fn ImagemorphopenPoint::y(self : ImagemorphopenPoint) -> Double { self.y }

pub fn ImagemorphopenPoint::z(self : ImagemorphopenPoint) -> Double { self.z }

pub fn ImagemorphopenPoint::label(self : ImagemorphopenPoint) -> Int { self.label }

pub fn ImagemorphopenPoint::dist(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphopenPoint::add(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphopenPoint::sub(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphopenPoint::scale(self : ImagemorphopenPoint, s : Double) -> ImagemorphopenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphopenPoint::dot(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphopenPoint::cross(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphopenPoint::norm(self : ImagemorphopenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphopenPoint::normalize(self : ImagemorphopenPoint) -> ImagemorphopenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphopenPoint::negate(self : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphopenPoint::mid(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphopenPoint::lerp(self : ImagemorphopenPoint, other : ImagemorphopenPoint, t : Double) -> ImagemorphopenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphopenPoint::to_string(self : ImagemorphopenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_open_make_series(vals : Array[Double], name : String) -> ImagemorphopenSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphopenSeries::len(self : ImagemorphopenSeries) -> Int { self.vals.length() }

pub fn ImagemorphopenSeries::sum(self : ImagemorphopenSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphopenSeries::mean(self : ImagemorphopenSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphopenSeries::min(self : ImagemorphopenSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphopenSeries::max(self : ImagemorphopenSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphopenSeries::range(self : ImagemorphopenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphopenSeries::variance(self : ImagemorphopenSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphopenSeries::std(self : ImagemorphopenSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphopenSeries::median(self : ImagemorphopenSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphopenSeries::scale(self : ImagemorphopenSeries, f : Double) -> ImagemorphopenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::add(self : ImagemorphopenSeries, other : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::sub(self : ImagemorphopenSeries, other : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::normalize(self : ImagemorphopenSeries) -> ImagemorphopenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphopenSeries::cumsum(self : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphopenSeries::to_string(self : ImagemorphopenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_open_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_open_matrix_identity(n : Int) -> ImagemorphopenMatrix {
  let m = image_morph_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphopenMatrix::get(self : ImagemorphopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphopenMatrix::transpose(self : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphopenMatrix::add(self : ImagemorphopenMatrix, other : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphopenMatrix::scale(self : ImagemorphopenMatrix, s : Double) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphopenMatrix::multiply(self : ImagemorphopenMatrix, other : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if self.cols != other.rows { return image_morph_open_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_open_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagemorphopenMatrix::trace(self : ImagemorphopenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphopenMatrix::det(self : ImagemorphopenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphopenMatrix::norm(self : ImagemorphopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphopenMatrix::to_string(self : ImagemorphopenMatrix) -> String {
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

pub(all) struct ImagemorphopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_open_make_vector(comps : Array[Double]) -> ImagemorphopenVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_open_vector_zero(dim : Int) -> ImagemorphopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphopenVector::add(self : ImagemorphopenVector, other : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphopenVector::sub(self : ImagemorphopenVector, other : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphopenVector::scale(self : ImagemorphopenVector, s : Double) -> ImagemorphopenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphopenVector::dot(self : ImagemorphopenVector, other : ImagemorphopenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphopenVector::norm(self : ImagemorphopenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphopenVector::normalize(self : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphopenVector::dist(self : ImagemorphopenVector, other : ImagemorphopenVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphopenVector::to_string(self : ImagemorphopenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_frame_make(size : Int) -> ImagemorphopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenFrame::len(self : ImagemorphopenFrame) -> Int { self.size }

pub fn ImagemorphopenFrame::get(self : ImagemorphopenFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenFrame::set(self : ImagemorphopenFrame, i : Int, v : Double) -> ImagemorphopenFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenFrame::sum(self : ImagemorphopenFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenFrame::mean(self : ImagemorphopenFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenFrame::scale(self : ImagemorphopenFrame, f : Double) -> ImagemorphopenFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenFrame::add(self : ImagemorphopenFrame, other : ImagemorphopenFrame) -> ImagemorphopenFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenFrame::copy(self : ImagemorphopenFrame) -> ImagemorphopenFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenFrame::fill(self : ImagemorphopenFrame, v : Double) -> ImagemorphopenFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenFrame::min(self : ImagemorphopenFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenFrame::max(self : ImagemorphopenFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenFrame::to_string(self : ImagemorphopenFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_table_make(size : Int) -> ImagemorphopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenTable::len(self : ImagemorphopenTable) -> Int { self.size }

pub fn ImagemorphopenTable::get(self : ImagemorphopenTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenTable::set(self : ImagemorphopenTable, i : Int, v : Double) -> ImagemorphopenTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenTable::sum(self : ImagemorphopenTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenTable::mean(self : ImagemorphopenTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenTable::scale(self : ImagemorphopenTable, f : Double) -> ImagemorphopenTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenTable::add(self : ImagemorphopenTable, other : ImagemorphopenTable) -> ImagemorphopenTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenTable::copy(self : ImagemorphopenTable) -> ImagemorphopenTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenTable::fill(self : ImagemorphopenTable, v : Double) -> ImagemorphopenTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenTable::min(self : ImagemorphopenTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenTable::max(self : ImagemorphopenTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenTable::to_string(self : ImagemorphopenTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_graphn_make(size : Int) -> ImagemorphopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenGraphN::len(self : ImagemorphopenGraphN) -> Int { self.size }

pub fn ImagemorphopenGraphN::get(self : ImagemorphopenGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenGraphN::set(self : ImagemorphopenGraphN, i : Int, v : Double) -> ImagemorphopenGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenGraphN::sum(self : ImagemorphopenGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenGraphN::mean(self : ImagemorphopenGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenGraphN::scale(self : ImagemorphopenGraphN, f : Double) -> ImagemorphopenGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenGraphN::add(self : ImagemorphopenGraphN, other : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenGraphN::copy(self : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenGraphN::fill(self : ImagemorphopenGraphN, v : Double) -> ImagemorphopenGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenGraphN::min(self : ImagemorphopenGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenGraphN::max(self : ImagemorphopenGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenGraphN::to_string(self : ImagemorphopenGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_node_make(size : Int) -> ImagemorphopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenNode::len(self : ImagemorphopenNode) -> Int { self.size }

pub fn ImagemorphopenNode::get(self : ImagemorphopenNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenNode::set(self : ImagemorphopenNode, i : Int, v : Double) -> ImagemorphopenNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenNode::sum(self : ImagemorphopenNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenNode::mean(self : ImagemorphopenNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenNode::scale(self : ImagemorphopenNode, f : Double) -> ImagemorphopenNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenNode::add(self : ImagemorphopenNode, other : ImagemorphopenNode) -> ImagemorphopenNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenNode::copy(self : ImagemorphopenNode) -> ImagemorphopenNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenNode::fill(self : ImagemorphopenNode, v : Double) -> ImagemorphopenNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenNode::min(self : ImagemorphopenNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenNode::max(self : ImagemorphopenNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenNode::to_string(self : ImagemorphopenNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_edge_make(size : Int) -> ImagemorphopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenEdge::len(self : ImagemorphopenEdge) -> Int { self.size }

pub fn ImagemorphopenEdge::get(self : ImagemorphopenEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenEdge::set(self : ImagemorphopenEdge, i : Int, v : Double) -> ImagemorphopenEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenEdge::sum(self : ImagemorphopenEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenEdge::mean(self : ImagemorphopenEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenEdge::scale(self : ImagemorphopenEdge, f : Double) -> ImagemorphopenEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenEdge::add(self : ImagemorphopenEdge, other : ImagemorphopenEdge) -> ImagemorphopenEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenEdge::copy(self : ImagemorphopenEdge) -> ImagemorphopenEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenEdge::fill(self : ImagemorphopenEdge, v : Double) -> ImagemorphopenEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenEdge::min(self : ImagemorphopenEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenEdge::max(self : ImagemorphopenEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenEdge::to_string(self : ImagemorphopenEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_path_make(size : Int) -> ImagemorphopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenPath::len(self : ImagemorphopenPath) -> Int { self.size }

pub fn ImagemorphopenPath::get(self : ImagemorphopenPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenPath::set(self : ImagemorphopenPath, i : Int, v : Double) -> ImagemorphopenPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenPath::sum(self : ImagemorphopenPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenPath::mean(self : ImagemorphopenPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenPath::scale(self : ImagemorphopenPath, f : Double) -> ImagemorphopenPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenPath::add(self : ImagemorphopenPath, other : ImagemorphopenPath) -> ImagemorphopenPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenPath::copy(self : ImagemorphopenPath) -> ImagemorphopenPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenPath::fill(self : ImagemorphopenPath, v : Double) -> ImagemorphopenPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenPath::min(self : ImagemorphopenPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenPath::max(self : ImagemorphopenPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenPath::to_string(self : ImagemorphopenPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cluster_make(size : Int) -> ImagemorphopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenCluster::len(self : ImagemorphopenCluster) -> Int { self.size }

pub fn ImagemorphopenCluster::get(self : ImagemorphopenCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenCluster::set(self : ImagemorphopenCluster, i : Int, v : Double) -> ImagemorphopenCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCluster::sum(self : ImagemorphopenCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenCluster::mean(self : ImagemorphopenCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenCluster::scale(self : ImagemorphopenCluster, f : Double) -> ImagemorphopenCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCluster::add(self : ImagemorphopenCluster, other : ImagemorphopenCluster) -> ImagemorphopenCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenCluster::copy(self : ImagemorphopenCluster) -> ImagemorphopenCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCluster::fill(self : ImagemorphopenCluster, v : Double) -> ImagemorphopenCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCluster::min(self : ImagemorphopenCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenCluster::max(self : ImagemorphopenCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenCluster::to_string(self : ImagemorphopenCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_model_make(size : Int) -> ImagemorphopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenModel::len(self : ImagemorphopenModel) -> Int { self.size }

pub fn ImagemorphopenModel::get(self : ImagemorphopenModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenModel::set(self : ImagemorphopenModel, i : Int, v : Double) -> ImagemorphopenModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenModel::sum(self : ImagemorphopenModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenModel::mean(self : ImagemorphopenModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenModel::scale(self : ImagemorphopenModel, f : Double) -> ImagemorphopenModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenModel::add(self : ImagemorphopenModel, other : ImagemorphopenModel) -> ImagemorphopenModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenModel::copy(self : ImagemorphopenModel) -> ImagemorphopenModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenModel::fill(self : ImagemorphopenModel, v : Double) -> ImagemorphopenModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenModel::min(self : ImagemorphopenModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenModel::max(self : ImagemorphopenModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenModel::to_string(self : ImagemorphopenModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_layer_make(size : Int) -> ImagemorphopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenLayer::len(self : ImagemorphopenLayer) -> Int { self.size }

pub fn ImagemorphopenLayer::get(self : ImagemorphopenLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenLayer::set(self : ImagemorphopenLayer, i : Int, v : Double) -> ImagemorphopenLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenLayer::sum(self : ImagemorphopenLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenLayer::mean(self : ImagemorphopenLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenLayer::scale(self : ImagemorphopenLayer, f : Double) -> ImagemorphopenLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenLayer::add(self : ImagemorphopenLayer, other : ImagemorphopenLayer) -> ImagemorphopenLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenLayer::copy(self : ImagemorphopenLayer) -> ImagemorphopenLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenLayer::fill(self : ImagemorphopenLayer, v : Double) -> ImagemorphopenLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenLayer::min(self : ImagemorphopenLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenLayer::max(self : ImagemorphopenLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenLayer::to_string(self : ImagemorphopenLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_buffer_make(size : Int) -> ImagemorphopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenBuffer::len(self : ImagemorphopenBuffer) -> Int { self.size }

pub fn ImagemorphopenBuffer::get(self : ImagemorphopenBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenBuffer::set(self : ImagemorphopenBuffer, i : Int, v : Double) -> ImagemorphopenBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenBuffer::sum(self : ImagemorphopenBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenBuffer::mean(self : ImagemorphopenBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenBuffer::scale(self : ImagemorphopenBuffer, f : Double) -> ImagemorphopenBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenBuffer::add(self : ImagemorphopenBuffer, other : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenBuffer::copy(self : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenBuffer::fill(self : ImagemorphopenBuffer, v : Double) -> ImagemorphopenBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenBuffer::min(self : ImagemorphopenBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenBuffer::max(self : ImagemorphopenBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenBuffer::to_string(self : ImagemorphopenBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cursor_make(size : Int) -> ImagemorphopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenCursor::len(self : ImagemorphopenCursor) -> Int { self.size }

pub fn ImagemorphopenCursor::get(self : ImagemorphopenCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenCursor::set(self : ImagemorphopenCursor, i : Int, v : Double) -> ImagemorphopenCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCursor::sum(self : ImagemorphopenCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenCursor::mean(self : ImagemorphopenCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenCursor::scale(self : ImagemorphopenCursor, f : Double) -> ImagemorphopenCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCursor::add(self : ImagemorphopenCursor, other : ImagemorphopenCursor) -> ImagemorphopenCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenCursor::copy(self : ImagemorphopenCursor) -> ImagemorphopenCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCursor::fill(self : ImagemorphopenCursor, v : Double) -> ImagemorphopenCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenCursor::min(self : ImagemorphopenCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenCursor::max(self : ImagemorphopenCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenCursor::to_string(self : ImagemorphopenCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_view_make(size : Int) -> ImagemorphopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenView::len(self : ImagemorphopenView) -> Int { self.size }

pub fn ImagemorphopenView::get(self : ImagemorphopenView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenView::set(self : ImagemorphopenView, i : Int, v : Double) -> ImagemorphopenView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenView::sum(self : ImagemorphopenView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenView::mean(self : ImagemorphopenView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenView::scale(self : ImagemorphopenView, f : Double) -> ImagemorphopenView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenView::add(self : ImagemorphopenView, other : ImagemorphopenView) -> ImagemorphopenView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenView::copy(self : ImagemorphopenView) -> ImagemorphopenView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenView::fill(self : ImagemorphopenView, v : Double) -> ImagemorphopenView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenView::min(self : ImagemorphopenView) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenView::max(self : ImagemorphopenView) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenView::to_string(self : ImagemorphopenView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_range_make(size : Int) -> ImagemorphopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenRange::len(self : ImagemorphopenRange) -> Int { self.size }

pub fn ImagemorphopenRange::get(self : ImagemorphopenRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenRange::set(self : ImagemorphopenRange, i : Int, v : Double) -> ImagemorphopenRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenRange::sum(self : ImagemorphopenRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenRange::mean(self : ImagemorphopenRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenRange::scale(self : ImagemorphopenRange, f : Double) -> ImagemorphopenRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenRange::add(self : ImagemorphopenRange, other : ImagemorphopenRange) -> ImagemorphopenRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenRange::copy(self : ImagemorphopenRange) -> ImagemorphopenRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenRange::fill(self : ImagemorphopenRange, v : Double) -> ImagemorphopenRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenRange::min(self : ImagemorphopenRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenRange::max(self : ImagemorphopenRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenRange::to_string(self : ImagemorphopenRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_slice_make(size : Int) -> ImagemorphopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphopenSlice::len(self : ImagemorphopenSlice) -> Int { self.size }

pub fn ImagemorphopenSlice::get(self : ImagemorphopenSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphopenSlice::set(self : ImagemorphopenSlice, i : Int, v : Double) -> ImagemorphopenSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphopenSlice::sum(self : ImagemorphopenSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphopenSlice::mean(self : ImagemorphopenSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphopenSlice::scale(self : ImagemorphopenSlice, f : Double) -> ImagemorphopenSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenSlice::add(self : ImagemorphopenSlice, other : ImagemorphopenSlice) -> ImagemorphopenSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphopenSlice::copy(self : ImagemorphopenSlice) -> ImagemorphopenSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenSlice::fill(self : ImagemorphopenSlice, v : Double) -> ImagemorphopenSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphopenSlice::min(self : ImagemorphopenSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphopenSlice::max(self : ImagemorphopenSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphopenSlice::to_string(self : ImagemorphopenSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

