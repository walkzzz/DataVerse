///===
/// extcore/image_morph_hit_miss

pub(all) struct ImagemorphhitmissPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_hit_miss_make_point(x : Double, y : Double) -> ImagemorphhitmissPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_hit_miss_make_point3(x : Double, y : Double, z : Double) -> ImagemorphhitmissPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphhitmissPoint::x(self : ImagemorphhitmissPoint) -> Double { self.x }

pub fn ImagemorphhitmissPoint::y(self : ImagemorphhitmissPoint) -> Double { self.y }

pub fn ImagemorphhitmissPoint::z(self : ImagemorphhitmissPoint) -> Double { self.z }

pub fn ImagemorphhitmissPoint::label(self : ImagemorphhitmissPoint) -> Int { self.label }

pub fn ImagemorphhitmissPoint::dist(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphhitmissPoint::add(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::sub(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::scale(self : ImagemorphhitmissPoint, s : Double) -> ImagemorphhitmissPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphhitmissPoint::dot(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphhitmissPoint::cross(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphhitmissPoint::norm(self : ImagemorphhitmissPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphhitmissPoint::normalize(self : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphhitmissPoint::negate(self : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::mid(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphhitmissPoint::lerp(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint, t : Double) -> ImagemorphhitmissPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphhitmissPoint::to_string(self : ImagemorphhitmissPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_hit_miss_make_series(vals : Array[Double], name : String) -> ImagemorphhitmissSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphhitmissSeries::len(self : ImagemorphhitmissSeries) -> Int { self.vals.length() }

pub fn ImagemorphhitmissSeries::sum(self : ImagemorphhitmissSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphhitmissSeries::mean(self : ImagemorphhitmissSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphhitmissSeries::min(self : ImagemorphhitmissSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphhitmissSeries::max(self : ImagemorphhitmissSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphhitmissSeries::range(self : ImagemorphhitmissSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphhitmissSeries::variance(self : ImagemorphhitmissSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphhitmissSeries::std(self : ImagemorphhitmissSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphhitmissSeries::median(self : ImagemorphhitmissSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphhitmissSeries::scale(self : ImagemorphhitmissSeries, f : Double) -> ImagemorphhitmissSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::add(self : ImagemorphhitmissSeries, other : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::sub(self : ImagemorphhitmissSeries, other : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::normalize(self : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphhitmissSeries::cumsum(self : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphhitmissSeries::to_string(self : ImagemorphhitmissSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphhitmissMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_hit_miss_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphhitmissMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_morph_hit_miss_matrix_identity(n : Int) -> ImagemorphhitmissMatrix {
  let m = image_morph_hit_miss_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphhitmissMatrix::get(self : ImagemorphhitmissMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphhitmissMatrix::transpose(self : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphhitmissMatrix::add(self : ImagemorphhitmissMatrix, other : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_hit_miss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphhitmissMatrix::scale(self : ImagemorphhitmissMatrix, s : Double) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphhitmissMatrix::multiply(self : ImagemorphhitmissMatrix, other : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if self.cols != other.rows { return image_morph_hit_miss_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_hit_miss_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagemorphhitmissMatrix::trace(self : ImagemorphhitmissMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphhitmissMatrix::det(self : ImagemorphhitmissMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphhitmissMatrix::norm(self : ImagemorphhitmissMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphhitmissMatrix::to_string(self : ImagemorphhitmissMatrix) -> String {
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

pub(all) struct ImagemorphhitmissVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_hit_miss_make_vector(comps : Array[Double]) -> ImagemorphhitmissVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_hit_miss_vector_zero(dim : Int) -> ImagemorphhitmissVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphhitmissVector::add(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphhitmissVector::sub(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphhitmissVector::scale(self : ImagemorphhitmissVector, s : Double) -> ImagemorphhitmissVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphhitmissVector::dot(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphhitmissVector::norm(self : ImagemorphhitmissVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphhitmissVector::normalize(self : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphhitmissVector::dist(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphhitmissVector::to_string(self : ImagemorphhitmissVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphhitmissFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_frame_make(size : Int) -> ImagemorphhitmissFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissFrame::len(self : ImagemorphhitmissFrame) -> Int { self.size }

pub fn ImagemorphhitmissFrame::get(self : ImagemorphhitmissFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissFrame::set(self : ImagemorphhitmissFrame, i : Int, v : Double) -> ImagemorphhitmissFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissFrame::sum(self : ImagemorphhitmissFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissFrame::mean(self : ImagemorphhitmissFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissFrame::scale(self : ImagemorphhitmissFrame, f : Double) -> ImagemorphhitmissFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissFrame::add(self : ImagemorphhitmissFrame, other : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissFrame::copy(self : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissFrame::fill(self : ImagemorphhitmissFrame, v : Double) -> ImagemorphhitmissFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissFrame::min(self : ImagemorphhitmissFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissFrame::max(self : ImagemorphhitmissFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissFrame::to_string(self : ImagemorphhitmissFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_table_make(size : Int) -> ImagemorphhitmissTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissTable::len(self : ImagemorphhitmissTable) -> Int { self.size }

pub fn ImagemorphhitmissTable::get(self : ImagemorphhitmissTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissTable::set(self : ImagemorphhitmissTable, i : Int, v : Double) -> ImagemorphhitmissTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissTable::sum(self : ImagemorphhitmissTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissTable::mean(self : ImagemorphhitmissTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissTable::scale(self : ImagemorphhitmissTable, f : Double) -> ImagemorphhitmissTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissTable::add(self : ImagemorphhitmissTable, other : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissTable::copy(self : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissTable::fill(self : ImagemorphhitmissTable, v : Double) -> ImagemorphhitmissTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissTable::min(self : ImagemorphhitmissTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissTable::max(self : ImagemorphhitmissTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissTable::to_string(self : ImagemorphhitmissTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_graphn_make(size : Int) -> ImagemorphhitmissGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissGraphN::len(self : ImagemorphhitmissGraphN) -> Int { self.size }

pub fn ImagemorphhitmissGraphN::get(self : ImagemorphhitmissGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissGraphN::set(self : ImagemorphhitmissGraphN, i : Int, v : Double) -> ImagemorphhitmissGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissGraphN::sum(self : ImagemorphhitmissGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissGraphN::mean(self : ImagemorphhitmissGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissGraphN::scale(self : ImagemorphhitmissGraphN, f : Double) -> ImagemorphhitmissGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissGraphN::add(self : ImagemorphhitmissGraphN, other : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissGraphN::copy(self : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissGraphN::fill(self : ImagemorphhitmissGraphN, v : Double) -> ImagemorphhitmissGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissGraphN::min(self : ImagemorphhitmissGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissGraphN::max(self : ImagemorphhitmissGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissGraphN::to_string(self : ImagemorphhitmissGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_node_make(size : Int) -> ImagemorphhitmissNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissNode::len(self : ImagemorphhitmissNode) -> Int { self.size }

pub fn ImagemorphhitmissNode::get(self : ImagemorphhitmissNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissNode::set(self : ImagemorphhitmissNode, i : Int, v : Double) -> ImagemorphhitmissNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissNode::sum(self : ImagemorphhitmissNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissNode::mean(self : ImagemorphhitmissNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissNode::scale(self : ImagemorphhitmissNode, f : Double) -> ImagemorphhitmissNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissNode::add(self : ImagemorphhitmissNode, other : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissNode::copy(self : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissNode::fill(self : ImagemorphhitmissNode, v : Double) -> ImagemorphhitmissNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissNode::min(self : ImagemorphhitmissNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissNode::max(self : ImagemorphhitmissNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissNode::to_string(self : ImagemorphhitmissNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_edge_make(size : Int) -> ImagemorphhitmissEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissEdge::len(self : ImagemorphhitmissEdge) -> Int { self.size }

pub fn ImagemorphhitmissEdge::get(self : ImagemorphhitmissEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissEdge::set(self : ImagemorphhitmissEdge, i : Int, v : Double) -> ImagemorphhitmissEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissEdge::sum(self : ImagemorphhitmissEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissEdge::mean(self : ImagemorphhitmissEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissEdge::scale(self : ImagemorphhitmissEdge, f : Double) -> ImagemorphhitmissEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissEdge::add(self : ImagemorphhitmissEdge, other : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissEdge::copy(self : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissEdge::fill(self : ImagemorphhitmissEdge, v : Double) -> ImagemorphhitmissEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissEdge::min(self : ImagemorphhitmissEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissEdge::max(self : ImagemorphhitmissEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissEdge::to_string(self : ImagemorphhitmissEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_path_make(size : Int) -> ImagemorphhitmissPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissPath::len(self : ImagemorphhitmissPath) -> Int { self.size }

pub fn ImagemorphhitmissPath::get(self : ImagemorphhitmissPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissPath::set(self : ImagemorphhitmissPath, i : Int, v : Double) -> ImagemorphhitmissPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissPath::sum(self : ImagemorphhitmissPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissPath::mean(self : ImagemorphhitmissPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissPath::scale(self : ImagemorphhitmissPath, f : Double) -> ImagemorphhitmissPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissPath::add(self : ImagemorphhitmissPath, other : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissPath::copy(self : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissPath::fill(self : ImagemorphhitmissPath, v : Double) -> ImagemorphhitmissPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissPath::min(self : ImagemorphhitmissPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissPath::max(self : ImagemorphhitmissPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissPath::to_string(self : ImagemorphhitmissPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cluster_make(size : Int) -> ImagemorphhitmissCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissCluster::len(self : ImagemorphhitmissCluster) -> Int { self.size }

pub fn ImagemorphhitmissCluster::get(self : ImagemorphhitmissCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissCluster::set(self : ImagemorphhitmissCluster, i : Int, v : Double) -> ImagemorphhitmissCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCluster::sum(self : ImagemorphhitmissCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissCluster::mean(self : ImagemorphhitmissCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissCluster::scale(self : ImagemorphhitmissCluster, f : Double) -> ImagemorphhitmissCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCluster::add(self : ImagemorphhitmissCluster, other : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissCluster::copy(self : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCluster::fill(self : ImagemorphhitmissCluster, v : Double) -> ImagemorphhitmissCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCluster::min(self : ImagemorphhitmissCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissCluster::max(self : ImagemorphhitmissCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissCluster::to_string(self : ImagemorphhitmissCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_model_make(size : Int) -> ImagemorphhitmissModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissModel::len(self : ImagemorphhitmissModel) -> Int { self.size }

pub fn ImagemorphhitmissModel::get(self : ImagemorphhitmissModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissModel::set(self : ImagemorphhitmissModel, i : Int, v : Double) -> ImagemorphhitmissModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissModel::sum(self : ImagemorphhitmissModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissModel::mean(self : ImagemorphhitmissModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissModel::scale(self : ImagemorphhitmissModel, f : Double) -> ImagemorphhitmissModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissModel::add(self : ImagemorphhitmissModel, other : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissModel::copy(self : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissModel::fill(self : ImagemorphhitmissModel, v : Double) -> ImagemorphhitmissModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissModel::min(self : ImagemorphhitmissModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissModel::max(self : ImagemorphhitmissModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissModel::to_string(self : ImagemorphhitmissModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_layer_make(size : Int) -> ImagemorphhitmissLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissLayer::len(self : ImagemorphhitmissLayer) -> Int { self.size }

pub fn ImagemorphhitmissLayer::get(self : ImagemorphhitmissLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissLayer::set(self : ImagemorphhitmissLayer, i : Int, v : Double) -> ImagemorphhitmissLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissLayer::sum(self : ImagemorphhitmissLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissLayer::mean(self : ImagemorphhitmissLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissLayer::scale(self : ImagemorphhitmissLayer, f : Double) -> ImagemorphhitmissLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissLayer::add(self : ImagemorphhitmissLayer, other : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissLayer::copy(self : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissLayer::fill(self : ImagemorphhitmissLayer, v : Double) -> ImagemorphhitmissLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissLayer::min(self : ImagemorphhitmissLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissLayer::max(self : ImagemorphhitmissLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissLayer::to_string(self : ImagemorphhitmissLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_buffer_make(size : Int) -> ImagemorphhitmissBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissBuffer::len(self : ImagemorphhitmissBuffer) -> Int { self.size }

pub fn ImagemorphhitmissBuffer::get(self : ImagemorphhitmissBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissBuffer::set(self : ImagemorphhitmissBuffer, i : Int, v : Double) -> ImagemorphhitmissBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissBuffer::sum(self : ImagemorphhitmissBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissBuffer::mean(self : ImagemorphhitmissBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissBuffer::scale(self : ImagemorphhitmissBuffer, f : Double) -> ImagemorphhitmissBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissBuffer::add(self : ImagemorphhitmissBuffer, other : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissBuffer::copy(self : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissBuffer::fill(self : ImagemorphhitmissBuffer, v : Double) -> ImagemorphhitmissBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissBuffer::min(self : ImagemorphhitmissBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissBuffer::max(self : ImagemorphhitmissBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissBuffer::to_string(self : ImagemorphhitmissBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cursor_make(size : Int) -> ImagemorphhitmissCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissCursor::len(self : ImagemorphhitmissCursor) -> Int { self.size }

pub fn ImagemorphhitmissCursor::get(self : ImagemorphhitmissCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissCursor::set(self : ImagemorphhitmissCursor, i : Int, v : Double) -> ImagemorphhitmissCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCursor::sum(self : ImagemorphhitmissCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissCursor::mean(self : ImagemorphhitmissCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissCursor::scale(self : ImagemorphhitmissCursor, f : Double) -> ImagemorphhitmissCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCursor::add(self : ImagemorphhitmissCursor, other : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissCursor::copy(self : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCursor::fill(self : ImagemorphhitmissCursor, v : Double) -> ImagemorphhitmissCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissCursor::min(self : ImagemorphhitmissCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissCursor::max(self : ImagemorphhitmissCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissCursor::to_string(self : ImagemorphhitmissCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_view_make(size : Int) -> ImagemorphhitmissView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissView::len(self : ImagemorphhitmissView) -> Int { self.size }

pub fn ImagemorphhitmissView::get(self : ImagemorphhitmissView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissView::set(self : ImagemorphhitmissView, i : Int, v : Double) -> ImagemorphhitmissView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissView::sum(self : ImagemorphhitmissView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissView::mean(self : ImagemorphhitmissView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissView::scale(self : ImagemorphhitmissView, f : Double) -> ImagemorphhitmissView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissView::add(self : ImagemorphhitmissView, other : ImagemorphhitmissView) -> ImagemorphhitmissView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissView::copy(self : ImagemorphhitmissView) -> ImagemorphhitmissView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissView::fill(self : ImagemorphhitmissView, v : Double) -> ImagemorphhitmissView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissView::min(self : ImagemorphhitmissView) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissView::max(self : ImagemorphhitmissView) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissView::to_string(self : ImagemorphhitmissView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_range_make(size : Int) -> ImagemorphhitmissRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissRange::len(self : ImagemorphhitmissRange) -> Int { self.size }

pub fn ImagemorphhitmissRange::get(self : ImagemorphhitmissRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissRange::set(self : ImagemorphhitmissRange, i : Int, v : Double) -> ImagemorphhitmissRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissRange::sum(self : ImagemorphhitmissRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissRange::mean(self : ImagemorphhitmissRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissRange::scale(self : ImagemorphhitmissRange, f : Double) -> ImagemorphhitmissRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissRange::add(self : ImagemorphhitmissRange, other : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissRange::copy(self : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissRange::fill(self : ImagemorphhitmissRange, v : Double) -> ImagemorphhitmissRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissRange::min(self : ImagemorphhitmissRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissRange::max(self : ImagemorphhitmissRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissRange::to_string(self : ImagemorphhitmissRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_slice_make(size : Int) -> ImagemorphhitmissSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphhitmissSlice::len(self : ImagemorphhitmissSlice) -> Int { self.size }

pub fn ImagemorphhitmissSlice::get(self : ImagemorphhitmissSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphhitmissSlice::set(self : ImagemorphhitmissSlice, i : Int, v : Double) -> ImagemorphhitmissSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissSlice::sum(self : ImagemorphhitmissSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphhitmissSlice::mean(self : ImagemorphhitmissSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphhitmissSlice::scale(self : ImagemorphhitmissSlice, f : Double) -> ImagemorphhitmissSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissSlice::add(self : ImagemorphhitmissSlice, other : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphhitmissSlice::copy(self : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissSlice::fill(self : ImagemorphhitmissSlice, v : Double) -> ImagemorphhitmissSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphhitmissSlice::min(self : ImagemorphhitmissSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphhitmissSlice::max(self : ImagemorphhitmissSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphhitmissSlice::to_string(self : ImagemorphhitmissSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

