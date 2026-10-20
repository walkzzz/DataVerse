///===
/// extcore/image_morph_thinning

pub(all) struct ImagemorphthinningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_thinning_make_point(x : Double, y : Double) -> ImagemorphthinningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_thinning_make_point3(x : Double, y : Double, z : Double) -> ImagemorphthinningPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphthinningPoint::x(self : ImagemorphthinningPoint) -> Double { self.x }

pub fn ImagemorphthinningPoint::y(self : ImagemorphthinningPoint) -> Double { self.y }

pub fn ImagemorphthinningPoint::z(self : ImagemorphthinningPoint) -> Double { self.z }

pub fn ImagemorphthinningPoint::label(self : ImagemorphthinningPoint) -> Int { self.label }

pub fn ImagemorphthinningPoint::dist(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphthinningPoint::add(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphthinningPoint::sub(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphthinningPoint::scale(self : ImagemorphthinningPoint, s : Double) -> ImagemorphthinningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphthinningPoint::dot(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphthinningPoint::cross(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphthinningPoint::norm(self : ImagemorphthinningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphthinningPoint::normalize(self : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphthinningPoint::negate(self : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphthinningPoint::mid(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphthinningPoint::lerp(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint, t : Double) -> ImagemorphthinningPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphthinningPoint::to_string(self : ImagemorphthinningPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphthinningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_thinning_make_series(vals : Array[Double], name : String) -> ImagemorphthinningSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphthinningSeries::len(self : ImagemorphthinningSeries) -> Int { self.vals.length() }

pub fn ImagemorphthinningSeries::sum(self : ImagemorphthinningSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphthinningSeries::mean(self : ImagemorphthinningSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphthinningSeries::min(self : ImagemorphthinningSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphthinningSeries::max(self : ImagemorphthinningSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphthinningSeries::range(self : ImagemorphthinningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphthinningSeries::variance(self : ImagemorphthinningSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphthinningSeries::std(self : ImagemorphthinningSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphthinningSeries::median(self : ImagemorphthinningSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphthinningSeries::scale(self : ImagemorphthinningSeries, f : Double) -> ImagemorphthinningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::add(self : ImagemorphthinningSeries, other : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::sub(self : ImagemorphthinningSeries, other : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::normalize(self : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphthinningSeries::cumsum(self : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphthinningSeries::to_string(self : ImagemorphthinningSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphthinningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_thinning_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphthinningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_thinning_matrix_identity(n : Int) -> ImagemorphthinningMatrix {
  let m = image_morph_thinning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphthinningMatrix::get(self : ImagemorphthinningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphthinningMatrix::transpose(self : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphthinningMatrix::add(self : ImagemorphthinningMatrix, other : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_thinning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphthinningMatrix::scale(self : ImagemorphthinningMatrix, s : Double) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphthinningMatrix::multiply(self : ImagemorphthinningMatrix, other : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if self.cols != other.rows { return image_morph_thinning_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_thinning_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagemorphthinningMatrix::trace(self : ImagemorphthinningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphthinningMatrix::det(self : ImagemorphthinningMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphthinningMatrix::norm(self : ImagemorphthinningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphthinningMatrix::to_string(self : ImagemorphthinningMatrix) -> String {
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

pub(all) struct ImagemorphthinningVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_thinning_make_vector(comps : Array[Double]) -> ImagemorphthinningVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_thinning_vector_zero(dim : Int) -> ImagemorphthinningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphthinningVector::add(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphthinningVector::sub(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphthinningVector::scale(self : ImagemorphthinningVector, s : Double) -> ImagemorphthinningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphthinningVector::dot(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphthinningVector::norm(self : ImagemorphthinningVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphthinningVector::normalize(self : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphthinningVector::dist(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphthinningVector::to_string(self : ImagemorphthinningVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphthinningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_frame_make(size : Int) -> ImagemorphthinningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningFrame::len(self : ImagemorphthinningFrame) -> Int { self.size }

pub fn ImagemorphthinningFrame::get(self : ImagemorphthinningFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningFrame::set(self : ImagemorphthinningFrame, i : Int, v : Double) -> ImagemorphthinningFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningFrame::sum(self : ImagemorphthinningFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningFrame::mean(self : ImagemorphthinningFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningFrame::scale(self : ImagemorphthinningFrame, f : Double) -> ImagemorphthinningFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningFrame::add(self : ImagemorphthinningFrame, other : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningFrame::copy(self : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningFrame::fill(self : ImagemorphthinningFrame, v : Double) -> ImagemorphthinningFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningFrame::min(self : ImagemorphthinningFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningFrame::max(self : ImagemorphthinningFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningFrame::to_string(self : ImagemorphthinningFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_table_make(size : Int) -> ImagemorphthinningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningTable::len(self : ImagemorphthinningTable) -> Int { self.size }

pub fn ImagemorphthinningTable::get(self : ImagemorphthinningTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningTable::set(self : ImagemorphthinningTable, i : Int, v : Double) -> ImagemorphthinningTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningTable::sum(self : ImagemorphthinningTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningTable::mean(self : ImagemorphthinningTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningTable::scale(self : ImagemorphthinningTable, f : Double) -> ImagemorphthinningTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningTable::add(self : ImagemorphthinningTable, other : ImagemorphthinningTable) -> ImagemorphthinningTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningTable::copy(self : ImagemorphthinningTable) -> ImagemorphthinningTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningTable::fill(self : ImagemorphthinningTable, v : Double) -> ImagemorphthinningTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningTable::min(self : ImagemorphthinningTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningTable::max(self : ImagemorphthinningTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningTable::to_string(self : ImagemorphthinningTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_graphn_make(size : Int) -> ImagemorphthinningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningGraphN::len(self : ImagemorphthinningGraphN) -> Int { self.size }

pub fn ImagemorphthinningGraphN::get(self : ImagemorphthinningGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningGraphN::set(self : ImagemorphthinningGraphN, i : Int, v : Double) -> ImagemorphthinningGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningGraphN::sum(self : ImagemorphthinningGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningGraphN::mean(self : ImagemorphthinningGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningGraphN::scale(self : ImagemorphthinningGraphN, f : Double) -> ImagemorphthinningGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningGraphN::add(self : ImagemorphthinningGraphN, other : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningGraphN::copy(self : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningGraphN::fill(self : ImagemorphthinningGraphN, v : Double) -> ImagemorphthinningGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningGraphN::min(self : ImagemorphthinningGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningGraphN::max(self : ImagemorphthinningGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningGraphN::to_string(self : ImagemorphthinningGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_node_make(size : Int) -> ImagemorphthinningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningNode::len(self : ImagemorphthinningNode) -> Int { self.size }

pub fn ImagemorphthinningNode::get(self : ImagemorphthinningNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningNode::set(self : ImagemorphthinningNode, i : Int, v : Double) -> ImagemorphthinningNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningNode::sum(self : ImagemorphthinningNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningNode::mean(self : ImagemorphthinningNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningNode::scale(self : ImagemorphthinningNode, f : Double) -> ImagemorphthinningNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningNode::add(self : ImagemorphthinningNode, other : ImagemorphthinningNode) -> ImagemorphthinningNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningNode::copy(self : ImagemorphthinningNode) -> ImagemorphthinningNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningNode::fill(self : ImagemorphthinningNode, v : Double) -> ImagemorphthinningNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningNode::min(self : ImagemorphthinningNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningNode::max(self : ImagemorphthinningNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningNode::to_string(self : ImagemorphthinningNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_edge_make(size : Int) -> ImagemorphthinningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningEdge::len(self : ImagemorphthinningEdge) -> Int { self.size }

pub fn ImagemorphthinningEdge::get(self : ImagemorphthinningEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningEdge::set(self : ImagemorphthinningEdge, i : Int, v : Double) -> ImagemorphthinningEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningEdge::sum(self : ImagemorphthinningEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningEdge::mean(self : ImagemorphthinningEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningEdge::scale(self : ImagemorphthinningEdge, f : Double) -> ImagemorphthinningEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningEdge::add(self : ImagemorphthinningEdge, other : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningEdge::copy(self : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningEdge::fill(self : ImagemorphthinningEdge, v : Double) -> ImagemorphthinningEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningEdge::min(self : ImagemorphthinningEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningEdge::max(self : ImagemorphthinningEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningEdge::to_string(self : ImagemorphthinningEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_path_make(size : Int) -> ImagemorphthinningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningPath::len(self : ImagemorphthinningPath) -> Int { self.size }

pub fn ImagemorphthinningPath::get(self : ImagemorphthinningPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningPath::set(self : ImagemorphthinningPath, i : Int, v : Double) -> ImagemorphthinningPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningPath::sum(self : ImagemorphthinningPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningPath::mean(self : ImagemorphthinningPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningPath::scale(self : ImagemorphthinningPath, f : Double) -> ImagemorphthinningPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningPath::add(self : ImagemorphthinningPath, other : ImagemorphthinningPath) -> ImagemorphthinningPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningPath::copy(self : ImagemorphthinningPath) -> ImagemorphthinningPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningPath::fill(self : ImagemorphthinningPath, v : Double) -> ImagemorphthinningPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningPath::min(self : ImagemorphthinningPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningPath::max(self : ImagemorphthinningPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningPath::to_string(self : ImagemorphthinningPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cluster_make(size : Int) -> ImagemorphthinningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningCluster::len(self : ImagemorphthinningCluster) -> Int { self.size }

pub fn ImagemorphthinningCluster::get(self : ImagemorphthinningCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningCluster::set(self : ImagemorphthinningCluster, i : Int, v : Double) -> ImagemorphthinningCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCluster::sum(self : ImagemorphthinningCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningCluster::mean(self : ImagemorphthinningCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningCluster::scale(self : ImagemorphthinningCluster, f : Double) -> ImagemorphthinningCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCluster::add(self : ImagemorphthinningCluster, other : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningCluster::copy(self : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCluster::fill(self : ImagemorphthinningCluster, v : Double) -> ImagemorphthinningCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCluster::min(self : ImagemorphthinningCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningCluster::max(self : ImagemorphthinningCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningCluster::to_string(self : ImagemorphthinningCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_model_make(size : Int) -> ImagemorphthinningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningModel::len(self : ImagemorphthinningModel) -> Int { self.size }

pub fn ImagemorphthinningModel::get(self : ImagemorphthinningModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningModel::set(self : ImagemorphthinningModel, i : Int, v : Double) -> ImagemorphthinningModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningModel::sum(self : ImagemorphthinningModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningModel::mean(self : ImagemorphthinningModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningModel::scale(self : ImagemorphthinningModel, f : Double) -> ImagemorphthinningModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningModel::add(self : ImagemorphthinningModel, other : ImagemorphthinningModel) -> ImagemorphthinningModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningModel::copy(self : ImagemorphthinningModel) -> ImagemorphthinningModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningModel::fill(self : ImagemorphthinningModel, v : Double) -> ImagemorphthinningModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningModel::min(self : ImagemorphthinningModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningModel::max(self : ImagemorphthinningModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningModel::to_string(self : ImagemorphthinningModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_layer_make(size : Int) -> ImagemorphthinningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningLayer::len(self : ImagemorphthinningLayer) -> Int { self.size }

pub fn ImagemorphthinningLayer::get(self : ImagemorphthinningLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningLayer::set(self : ImagemorphthinningLayer, i : Int, v : Double) -> ImagemorphthinningLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningLayer::sum(self : ImagemorphthinningLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningLayer::mean(self : ImagemorphthinningLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningLayer::scale(self : ImagemorphthinningLayer, f : Double) -> ImagemorphthinningLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningLayer::add(self : ImagemorphthinningLayer, other : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningLayer::copy(self : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningLayer::fill(self : ImagemorphthinningLayer, v : Double) -> ImagemorphthinningLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningLayer::min(self : ImagemorphthinningLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningLayer::max(self : ImagemorphthinningLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningLayer::to_string(self : ImagemorphthinningLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_buffer_make(size : Int) -> ImagemorphthinningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningBuffer::len(self : ImagemorphthinningBuffer) -> Int { self.size }

pub fn ImagemorphthinningBuffer::get(self : ImagemorphthinningBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningBuffer::set(self : ImagemorphthinningBuffer, i : Int, v : Double) -> ImagemorphthinningBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningBuffer::sum(self : ImagemorphthinningBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningBuffer::mean(self : ImagemorphthinningBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningBuffer::scale(self : ImagemorphthinningBuffer, f : Double) -> ImagemorphthinningBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningBuffer::add(self : ImagemorphthinningBuffer, other : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningBuffer::copy(self : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningBuffer::fill(self : ImagemorphthinningBuffer, v : Double) -> ImagemorphthinningBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningBuffer::min(self : ImagemorphthinningBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningBuffer::max(self : ImagemorphthinningBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningBuffer::to_string(self : ImagemorphthinningBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cursor_make(size : Int) -> ImagemorphthinningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningCursor::len(self : ImagemorphthinningCursor) -> Int { self.size }

pub fn ImagemorphthinningCursor::get(self : ImagemorphthinningCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningCursor::set(self : ImagemorphthinningCursor, i : Int, v : Double) -> ImagemorphthinningCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCursor::sum(self : ImagemorphthinningCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningCursor::mean(self : ImagemorphthinningCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningCursor::scale(self : ImagemorphthinningCursor, f : Double) -> ImagemorphthinningCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCursor::add(self : ImagemorphthinningCursor, other : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningCursor::copy(self : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCursor::fill(self : ImagemorphthinningCursor, v : Double) -> ImagemorphthinningCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningCursor::min(self : ImagemorphthinningCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningCursor::max(self : ImagemorphthinningCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningCursor::to_string(self : ImagemorphthinningCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_view_make(size : Int) -> ImagemorphthinningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningView::len(self : ImagemorphthinningView) -> Int { self.size }

pub fn ImagemorphthinningView::get(self : ImagemorphthinningView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningView::set(self : ImagemorphthinningView, i : Int, v : Double) -> ImagemorphthinningView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningView::sum(self : ImagemorphthinningView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningView::mean(self : ImagemorphthinningView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningView::scale(self : ImagemorphthinningView, f : Double) -> ImagemorphthinningView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningView::add(self : ImagemorphthinningView, other : ImagemorphthinningView) -> ImagemorphthinningView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningView::copy(self : ImagemorphthinningView) -> ImagemorphthinningView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningView::fill(self : ImagemorphthinningView, v : Double) -> ImagemorphthinningView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningView::min(self : ImagemorphthinningView) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningView::max(self : ImagemorphthinningView) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningView::to_string(self : ImagemorphthinningView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_range_make(size : Int) -> ImagemorphthinningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningRange::len(self : ImagemorphthinningRange) -> Int { self.size }

pub fn ImagemorphthinningRange::get(self : ImagemorphthinningRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningRange::set(self : ImagemorphthinningRange, i : Int, v : Double) -> ImagemorphthinningRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningRange::sum(self : ImagemorphthinningRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningRange::mean(self : ImagemorphthinningRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningRange::scale(self : ImagemorphthinningRange, f : Double) -> ImagemorphthinningRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningRange::add(self : ImagemorphthinningRange, other : ImagemorphthinningRange) -> ImagemorphthinningRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningRange::copy(self : ImagemorphthinningRange) -> ImagemorphthinningRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningRange::fill(self : ImagemorphthinningRange, v : Double) -> ImagemorphthinningRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningRange::min(self : ImagemorphthinningRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningRange::max(self : ImagemorphthinningRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningRange::to_string(self : ImagemorphthinningRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_slice_make(size : Int) -> ImagemorphthinningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphthinningSlice::len(self : ImagemorphthinningSlice) -> Int { self.size }

pub fn ImagemorphthinningSlice::get(self : ImagemorphthinningSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphthinningSlice::set(self : ImagemorphthinningSlice, i : Int, v : Double) -> ImagemorphthinningSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningSlice::sum(self : ImagemorphthinningSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphthinningSlice::mean(self : ImagemorphthinningSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphthinningSlice::scale(self : ImagemorphthinningSlice, f : Double) -> ImagemorphthinningSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningSlice::add(self : ImagemorphthinningSlice, other : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphthinningSlice::copy(self : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningSlice::fill(self : ImagemorphthinningSlice, v : Double) -> ImagemorphthinningSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphthinningSlice::min(self : ImagemorphthinningSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphthinningSlice::max(self : ImagemorphthinningSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphthinningSlice::to_string(self : ImagemorphthinningSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

