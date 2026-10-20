///===
/// extcore/image_morph_tophat

pub(all) struct ImagemorphtophatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_tophat_make_point(x : Double, y : Double) -> ImagemorphtophatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_tophat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphtophatPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphtophatPoint::x(self : ImagemorphtophatPoint) -> Double { self.x }

pub fn ImagemorphtophatPoint::y(self : ImagemorphtophatPoint) -> Double { self.y }

pub fn ImagemorphtophatPoint::z(self : ImagemorphtophatPoint) -> Double { self.z }

pub fn ImagemorphtophatPoint::label(self : ImagemorphtophatPoint) -> Int { self.label }

pub fn ImagemorphtophatPoint::dist(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphtophatPoint::add(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphtophatPoint::sub(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphtophatPoint::scale(self : ImagemorphtophatPoint, s : Double) -> ImagemorphtophatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphtophatPoint::dot(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphtophatPoint::cross(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphtophatPoint::norm(self : ImagemorphtophatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphtophatPoint::normalize(self : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphtophatPoint::negate(self : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphtophatPoint::mid(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphtophatPoint::lerp(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint, t : Double) -> ImagemorphtophatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphtophatPoint::to_string(self : ImagemorphtophatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphtophatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_tophat_make_series(vals : Array[Double], name : String) -> ImagemorphtophatSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphtophatSeries::len(self : ImagemorphtophatSeries) -> Int { self.vals.length() }

pub fn ImagemorphtophatSeries::sum(self : ImagemorphtophatSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphtophatSeries::mean(self : ImagemorphtophatSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphtophatSeries::min(self : ImagemorphtophatSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphtophatSeries::max(self : ImagemorphtophatSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphtophatSeries::range(self : ImagemorphtophatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphtophatSeries::variance(self : ImagemorphtophatSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphtophatSeries::std(self : ImagemorphtophatSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphtophatSeries::median(self : ImagemorphtophatSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphtophatSeries::scale(self : ImagemorphtophatSeries, f : Double) -> ImagemorphtophatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::add(self : ImagemorphtophatSeries, other : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::sub(self : ImagemorphtophatSeries, other : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::normalize(self : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphtophatSeries::cumsum(self : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphtophatSeries::to_string(self : ImagemorphtophatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphtophatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_tophat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphtophatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_tophat_matrix_identity(n : Int) -> ImagemorphtophatMatrix {
  let m = image_morph_tophat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphtophatMatrix::get(self : ImagemorphtophatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphtophatMatrix::transpose(self : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphtophatMatrix::add(self : ImagemorphtophatMatrix, other : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_tophat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphtophatMatrix::scale(self : ImagemorphtophatMatrix, s : Double) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphtophatMatrix::multiply(self : ImagemorphtophatMatrix, other : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if self.cols != other.rows { return image_morph_tophat_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_tophat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphtophatMatrix::trace(self : ImagemorphtophatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphtophatMatrix::det(self : ImagemorphtophatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphtophatMatrix::norm(self : ImagemorphtophatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphtophatMatrix::to_string(self : ImagemorphtophatMatrix) -> String {
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

pub(all) struct ImagemorphtophatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_tophat_make_vector(comps : Array[Double]) -> ImagemorphtophatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_tophat_vector_zero(dim : Int) -> ImagemorphtophatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphtophatVector::add(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphtophatVector::sub(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphtophatVector::scale(self : ImagemorphtophatVector, s : Double) -> ImagemorphtophatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphtophatVector::dot(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphtophatVector::norm(self : ImagemorphtophatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphtophatVector::normalize(self : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphtophatVector::dist(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphtophatVector::to_string(self : ImagemorphtophatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphtophatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_frame_make(size : Int) -> ImagemorphtophatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatFrame::len(self : ImagemorphtophatFrame) -> Int { self.size }

pub fn ImagemorphtophatFrame::get(self : ImagemorphtophatFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatFrame::set(self : ImagemorphtophatFrame, i : Int, v : Double) -> ImagemorphtophatFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatFrame::sum(self : ImagemorphtophatFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatFrame::mean(self : ImagemorphtophatFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatFrame::scale(self : ImagemorphtophatFrame, f : Double) -> ImagemorphtophatFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatFrame::add(self : ImagemorphtophatFrame, other : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatFrame::copy(self : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatFrame::fill(self : ImagemorphtophatFrame, v : Double) -> ImagemorphtophatFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatFrame::min(self : ImagemorphtophatFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatFrame::max(self : ImagemorphtophatFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatFrame::to_string(self : ImagemorphtophatFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_table_make(size : Int) -> ImagemorphtophatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatTable::len(self : ImagemorphtophatTable) -> Int { self.size }

pub fn ImagemorphtophatTable::get(self : ImagemorphtophatTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatTable::set(self : ImagemorphtophatTable, i : Int, v : Double) -> ImagemorphtophatTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatTable::sum(self : ImagemorphtophatTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatTable::mean(self : ImagemorphtophatTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatTable::scale(self : ImagemorphtophatTable, f : Double) -> ImagemorphtophatTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatTable::add(self : ImagemorphtophatTable, other : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatTable::copy(self : ImagemorphtophatTable) -> ImagemorphtophatTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatTable::fill(self : ImagemorphtophatTable, v : Double) -> ImagemorphtophatTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatTable::min(self : ImagemorphtophatTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatTable::max(self : ImagemorphtophatTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatTable::to_string(self : ImagemorphtophatTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_graphn_make(size : Int) -> ImagemorphtophatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatGraphN::len(self : ImagemorphtophatGraphN) -> Int { self.size }

pub fn ImagemorphtophatGraphN::get(self : ImagemorphtophatGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatGraphN::set(self : ImagemorphtophatGraphN, i : Int, v : Double) -> ImagemorphtophatGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatGraphN::sum(self : ImagemorphtophatGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatGraphN::mean(self : ImagemorphtophatGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatGraphN::scale(self : ImagemorphtophatGraphN, f : Double) -> ImagemorphtophatGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatGraphN::add(self : ImagemorphtophatGraphN, other : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatGraphN::copy(self : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatGraphN::fill(self : ImagemorphtophatGraphN, v : Double) -> ImagemorphtophatGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatGraphN::min(self : ImagemorphtophatGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatGraphN::max(self : ImagemorphtophatGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatGraphN::to_string(self : ImagemorphtophatGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_node_make(size : Int) -> ImagemorphtophatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatNode::len(self : ImagemorphtophatNode) -> Int { self.size }

pub fn ImagemorphtophatNode::get(self : ImagemorphtophatNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatNode::set(self : ImagemorphtophatNode, i : Int, v : Double) -> ImagemorphtophatNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatNode::sum(self : ImagemorphtophatNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatNode::mean(self : ImagemorphtophatNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatNode::scale(self : ImagemorphtophatNode, f : Double) -> ImagemorphtophatNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatNode::add(self : ImagemorphtophatNode, other : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatNode::copy(self : ImagemorphtophatNode) -> ImagemorphtophatNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatNode::fill(self : ImagemorphtophatNode, v : Double) -> ImagemorphtophatNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatNode::min(self : ImagemorphtophatNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatNode::max(self : ImagemorphtophatNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatNode::to_string(self : ImagemorphtophatNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_edge_make(size : Int) -> ImagemorphtophatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatEdge::len(self : ImagemorphtophatEdge) -> Int { self.size }

pub fn ImagemorphtophatEdge::get(self : ImagemorphtophatEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatEdge::set(self : ImagemorphtophatEdge, i : Int, v : Double) -> ImagemorphtophatEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatEdge::sum(self : ImagemorphtophatEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatEdge::mean(self : ImagemorphtophatEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatEdge::scale(self : ImagemorphtophatEdge, f : Double) -> ImagemorphtophatEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatEdge::add(self : ImagemorphtophatEdge, other : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatEdge::copy(self : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatEdge::fill(self : ImagemorphtophatEdge, v : Double) -> ImagemorphtophatEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatEdge::min(self : ImagemorphtophatEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatEdge::max(self : ImagemorphtophatEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatEdge::to_string(self : ImagemorphtophatEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_path_make(size : Int) -> ImagemorphtophatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatPath::len(self : ImagemorphtophatPath) -> Int { self.size }

pub fn ImagemorphtophatPath::get(self : ImagemorphtophatPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatPath::set(self : ImagemorphtophatPath, i : Int, v : Double) -> ImagemorphtophatPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatPath::sum(self : ImagemorphtophatPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatPath::mean(self : ImagemorphtophatPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatPath::scale(self : ImagemorphtophatPath, f : Double) -> ImagemorphtophatPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatPath::add(self : ImagemorphtophatPath, other : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatPath::copy(self : ImagemorphtophatPath) -> ImagemorphtophatPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatPath::fill(self : ImagemorphtophatPath, v : Double) -> ImagemorphtophatPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatPath::min(self : ImagemorphtophatPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatPath::max(self : ImagemorphtophatPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatPath::to_string(self : ImagemorphtophatPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cluster_make(size : Int) -> ImagemorphtophatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatCluster::len(self : ImagemorphtophatCluster) -> Int { self.size }

pub fn ImagemorphtophatCluster::get(self : ImagemorphtophatCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatCluster::set(self : ImagemorphtophatCluster, i : Int, v : Double) -> ImagemorphtophatCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCluster::sum(self : ImagemorphtophatCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatCluster::mean(self : ImagemorphtophatCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatCluster::scale(self : ImagemorphtophatCluster, f : Double) -> ImagemorphtophatCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCluster::add(self : ImagemorphtophatCluster, other : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatCluster::copy(self : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCluster::fill(self : ImagemorphtophatCluster, v : Double) -> ImagemorphtophatCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCluster::min(self : ImagemorphtophatCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatCluster::max(self : ImagemorphtophatCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatCluster::to_string(self : ImagemorphtophatCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_model_make(size : Int) -> ImagemorphtophatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatModel::len(self : ImagemorphtophatModel) -> Int { self.size }

pub fn ImagemorphtophatModel::get(self : ImagemorphtophatModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatModel::set(self : ImagemorphtophatModel, i : Int, v : Double) -> ImagemorphtophatModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatModel::sum(self : ImagemorphtophatModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatModel::mean(self : ImagemorphtophatModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatModel::scale(self : ImagemorphtophatModel, f : Double) -> ImagemorphtophatModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatModel::add(self : ImagemorphtophatModel, other : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatModel::copy(self : ImagemorphtophatModel) -> ImagemorphtophatModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatModel::fill(self : ImagemorphtophatModel, v : Double) -> ImagemorphtophatModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatModel::min(self : ImagemorphtophatModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatModel::max(self : ImagemorphtophatModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatModel::to_string(self : ImagemorphtophatModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_layer_make(size : Int) -> ImagemorphtophatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatLayer::len(self : ImagemorphtophatLayer) -> Int { self.size }

pub fn ImagemorphtophatLayer::get(self : ImagemorphtophatLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatLayer::set(self : ImagemorphtophatLayer, i : Int, v : Double) -> ImagemorphtophatLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatLayer::sum(self : ImagemorphtophatLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatLayer::mean(self : ImagemorphtophatLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatLayer::scale(self : ImagemorphtophatLayer, f : Double) -> ImagemorphtophatLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatLayer::add(self : ImagemorphtophatLayer, other : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatLayer::copy(self : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatLayer::fill(self : ImagemorphtophatLayer, v : Double) -> ImagemorphtophatLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatLayer::min(self : ImagemorphtophatLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatLayer::max(self : ImagemorphtophatLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatLayer::to_string(self : ImagemorphtophatLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_buffer_make(size : Int) -> ImagemorphtophatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatBuffer::len(self : ImagemorphtophatBuffer) -> Int { self.size }

pub fn ImagemorphtophatBuffer::get(self : ImagemorphtophatBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatBuffer::set(self : ImagemorphtophatBuffer, i : Int, v : Double) -> ImagemorphtophatBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatBuffer::sum(self : ImagemorphtophatBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatBuffer::mean(self : ImagemorphtophatBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatBuffer::scale(self : ImagemorphtophatBuffer, f : Double) -> ImagemorphtophatBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatBuffer::add(self : ImagemorphtophatBuffer, other : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatBuffer::copy(self : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatBuffer::fill(self : ImagemorphtophatBuffer, v : Double) -> ImagemorphtophatBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatBuffer::min(self : ImagemorphtophatBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatBuffer::max(self : ImagemorphtophatBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatBuffer::to_string(self : ImagemorphtophatBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cursor_make(size : Int) -> ImagemorphtophatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatCursor::len(self : ImagemorphtophatCursor) -> Int { self.size }

pub fn ImagemorphtophatCursor::get(self : ImagemorphtophatCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatCursor::set(self : ImagemorphtophatCursor, i : Int, v : Double) -> ImagemorphtophatCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCursor::sum(self : ImagemorphtophatCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatCursor::mean(self : ImagemorphtophatCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatCursor::scale(self : ImagemorphtophatCursor, f : Double) -> ImagemorphtophatCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCursor::add(self : ImagemorphtophatCursor, other : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatCursor::copy(self : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCursor::fill(self : ImagemorphtophatCursor, v : Double) -> ImagemorphtophatCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatCursor::min(self : ImagemorphtophatCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatCursor::max(self : ImagemorphtophatCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatCursor::to_string(self : ImagemorphtophatCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_view_make(size : Int) -> ImagemorphtophatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatView::len(self : ImagemorphtophatView) -> Int { self.size }

pub fn ImagemorphtophatView::get(self : ImagemorphtophatView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatView::set(self : ImagemorphtophatView, i : Int, v : Double) -> ImagemorphtophatView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatView::sum(self : ImagemorphtophatView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatView::mean(self : ImagemorphtophatView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatView::scale(self : ImagemorphtophatView, f : Double) -> ImagemorphtophatView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatView::add(self : ImagemorphtophatView, other : ImagemorphtophatView) -> ImagemorphtophatView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatView::copy(self : ImagemorphtophatView) -> ImagemorphtophatView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatView::fill(self : ImagemorphtophatView, v : Double) -> ImagemorphtophatView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatView::min(self : ImagemorphtophatView) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatView::max(self : ImagemorphtophatView) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatView::to_string(self : ImagemorphtophatView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_range_make(size : Int) -> ImagemorphtophatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatRange::len(self : ImagemorphtophatRange) -> Int { self.size }

pub fn ImagemorphtophatRange::get(self : ImagemorphtophatRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatRange::set(self : ImagemorphtophatRange, i : Int, v : Double) -> ImagemorphtophatRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatRange::sum(self : ImagemorphtophatRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatRange::mean(self : ImagemorphtophatRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatRange::scale(self : ImagemorphtophatRange, f : Double) -> ImagemorphtophatRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatRange::add(self : ImagemorphtophatRange, other : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatRange::copy(self : ImagemorphtophatRange) -> ImagemorphtophatRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatRange::fill(self : ImagemorphtophatRange, v : Double) -> ImagemorphtophatRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatRange::min(self : ImagemorphtophatRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatRange::max(self : ImagemorphtophatRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatRange::to_string(self : ImagemorphtophatRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_slice_make(size : Int) -> ImagemorphtophatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphtophatSlice::len(self : ImagemorphtophatSlice) -> Int { self.size }

pub fn ImagemorphtophatSlice::get(self : ImagemorphtophatSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphtophatSlice::set(self : ImagemorphtophatSlice, i : Int, v : Double) -> ImagemorphtophatSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatSlice::sum(self : ImagemorphtophatSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphtophatSlice::mean(self : ImagemorphtophatSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphtophatSlice::scale(self : ImagemorphtophatSlice, f : Double) -> ImagemorphtophatSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatSlice::add(self : ImagemorphtophatSlice, other : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphtophatSlice::copy(self : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatSlice::fill(self : ImagemorphtophatSlice, v : Double) -> ImagemorphtophatSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphtophatSlice::min(self : ImagemorphtophatSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphtophatSlice::max(self : ImagemorphtophatSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphtophatSlice::to_string(self : ImagemorphtophatSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

