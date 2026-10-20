///===
/// extcore/bio_seq_align_structural

pub(all) struct BioseqalignstructuralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_structural_make_point(x : Double, y : Double) -> BioseqalignstructuralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_structural_make_point3(x : Double, y : Double, z : Double) -> BioseqalignstructuralPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignstructuralPoint::x(self : BioseqalignstructuralPoint) -> Double { self.x }

pub fn BioseqalignstructuralPoint::y(self : BioseqalignstructuralPoint) -> Double { self.y }

pub fn BioseqalignstructuralPoint::z(self : BioseqalignstructuralPoint) -> Double { self.z }

pub fn BioseqalignstructuralPoint::label(self : BioseqalignstructuralPoint) -> Int { self.label }

pub fn BioseqalignstructuralPoint::dist(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignstructuralPoint::add(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::sub(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::scale(self : BioseqalignstructuralPoint, s : Double) -> BioseqalignstructuralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignstructuralPoint::dot(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignstructuralPoint::cross(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignstructuralPoint::norm(self : BioseqalignstructuralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignstructuralPoint::normalize(self : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignstructuralPoint::negate(self : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::mid(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignstructuralPoint::lerp(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint, t : Double) -> BioseqalignstructuralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignstructuralPoint::to_string(self : BioseqalignstructuralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_structural_make_series(vals : Array[Double], name : String) -> BioseqalignstructuralSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignstructuralSeries::len(self : BioseqalignstructuralSeries) -> Int { self.vals.length() }

pub fn BioseqalignstructuralSeries::sum(self : BioseqalignstructuralSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignstructuralSeries::mean(self : BioseqalignstructuralSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignstructuralSeries::min(self : BioseqalignstructuralSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignstructuralSeries::max(self : BioseqalignstructuralSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignstructuralSeries::range(self : BioseqalignstructuralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignstructuralSeries::variance(self : BioseqalignstructuralSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignstructuralSeries::std(self : BioseqalignstructuralSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignstructuralSeries::median(self : BioseqalignstructuralSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignstructuralSeries::scale(self : BioseqalignstructuralSeries, f : Double) -> BioseqalignstructuralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::add(self : BioseqalignstructuralSeries, other : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::sub(self : BioseqalignstructuralSeries, other : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::normalize(self : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignstructuralSeries::cumsum(self : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignstructuralSeries::to_string(self : BioseqalignstructuralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignstructuralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_structural_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignstructuralMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_seq_align_structural_matrix_identity(n : Int) -> BioseqalignstructuralMatrix {
  let m = bio_seq_align_structural_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignstructuralMatrix::get(self : BioseqalignstructuralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignstructuralMatrix::transpose(self : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignstructuralMatrix::add(self : BioseqalignstructuralMatrix, other : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_structural_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignstructuralMatrix::scale(self : BioseqalignstructuralMatrix, s : Double) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignstructuralMatrix::multiply(self : BioseqalignstructuralMatrix, other : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if self.cols != other.rows { return bio_seq_align_structural_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_structural_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqalignstructuralMatrix::trace(self : BioseqalignstructuralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignstructuralMatrix::det(self : BioseqalignstructuralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignstructuralMatrix::norm(self : BioseqalignstructuralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignstructuralMatrix::to_string(self : BioseqalignstructuralMatrix) -> String {
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

pub(all) struct BioseqalignstructuralVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_structural_make_vector(comps : Array[Double]) -> BioseqalignstructuralVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_structural_vector_zero(dim : Int) -> BioseqalignstructuralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignstructuralVector::add(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignstructuralVector::sub(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignstructuralVector::scale(self : BioseqalignstructuralVector, s : Double) -> BioseqalignstructuralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignstructuralVector::dot(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignstructuralVector::norm(self : BioseqalignstructuralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignstructuralVector::normalize(self : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignstructuralVector::dist(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignstructuralVector::to_string(self : BioseqalignstructuralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignstructuralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_frame_make(size : Int) -> BioseqalignstructuralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralFrame::len(self : BioseqalignstructuralFrame) -> Int { self.size }

pub fn BioseqalignstructuralFrame::get(self : BioseqalignstructuralFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralFrame::set(self : BioseqalignstructuralFrame, i : Int, v : Double) -> BioseqalignstructuralFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralFrame::sum(self : BioseqalignstructuralFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralFrame::mean(self : BioseqalignstructuralFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralFrame::scale(self : BioseqalignstructuralFrame, f : Double) -> BioseqalignstructuralFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralFrame::add(self : BioseqalignstructuralFrame, other : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralFrame::copy(self : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralFrame::fill(self : BioseqalignstructuralFrame, v : Double) -> BioseqalignstructuralFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralFrame::min(self : BioseqalignstructuralFrame) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralFrame::max(self : BioseqalignstructuralFrame) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralFrame::to_string(self : BioseqalignstructuralFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_table_make(size : Int) -> BioseqalignstructuralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralTable::len(self : BioseqalignstructuralTable) -> Int { self.size }

pub fn BioseqalignstructuralTable::get(self : BioseqalignstructuralTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralTable::set(self : BioseqalignstructuralTable, i : Int, v : Double) -> BioseqalignstructuralTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralTable::sum(self : BioseqalignstructuralTable) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralTable::mean(self : BioseqalignstructuralTable) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralTable::scale(self : BioseqalignstructuralTable, f : Double) -> BioseqalignstructuralTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralTable::add(self : BioseqalignstructuralTable, other : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralTable::copy(self : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralTable::fill(self : BioseqalignstructuralTable, v : Double) -> BioseqalignstructuralTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralTable::min(self : BioseqalignstructuralTable) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralTable::max(self : BioseqalignstructuralTable) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralTable::to_string(self : BioseqalignstructuralTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_graphn_make(size : Int) -> BioseqalignstructuralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralGraphN::len(self : BioseqalignstructuralGraphN) -> Int { self.size }

pub fn BioseqalignstructuralGraphN::get(self : BioseqalignstructuralGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralGraphN::set(self : BioseqalignstructuralGraphN, i : Int, v : Double) -> BioseqalignstructuralGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralGraphN::sum(self : BioseqalignstructuralGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralGraphN::mean(self : BioseqalignstructuralGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralGraphN::scale(self : BioseqalignstructuralGraphN, f : Double) -> BioseqalignstructuralGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralGraphN::add(self : BioseqalignstructuralGraphN, other : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralGraphN::copy(self : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralGraphN::fill(self : BioseqalignstructuralGraphN, v : Double) -> BioseqalignstructuralGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralGraphN::min(self : BioseqalignstructuralGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralGraphN::max(self : BioseqalignstructuralGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralGraphN::to_string(self : BioseqalignstructuralGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_node_make(size : Int) -> BioseqalignstructuralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralNode::len(self : BioseqalignstructuralNode) -> Int { self.size }

pub fn BioseqalignstructuralNode::get(self : BioseqalignstructuralNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralNode::set(self : BioseqalignstructuralNode, i : Int, v : Double) -> BioseqalignstructuralNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralNode::sum(self : BioseqalignstructuralNode) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralNode::mean(self : BioseqalignstructuralNode) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralNode::scale(self : BioseqalignstructuralNode, f : Double) -> BioseqalignstructuralNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralNode::add(self : BioseqalignstructuralNode, other : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralNode::copy(self : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralNode::fill(self : BioseqalignstructuralNode, v : Double) -> BioseqalignstructuralNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralNode::min(self : BioseqalignstructuralNode) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralNode::max(self : BioseqalignstructuralNode) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralNode::to_string(self : BioseqalignstructuralNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_edge_make(size : Int) -> BioseqalignstructuralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralEdge::len(self : BioseqalignstructuralEdge) -> Int { self.size }

pub fn BioseqalignstructuralEdge::get(self : BioseqalignstructuralEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralEdge::set(self : BioseqalignstructuralEdge, i : Int, v : Double) -> BioseqalignstructuralEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralEdge::sum(self : BioseqalignstructuralEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralEdge::mean(self : BioseqalignstructuralEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralEdge::scale(self : BioseqalignstructuralEdge, f : Double) -> BioseqalignstructuralEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralEdge::add(self : BioseqalignstructuralEdge, other : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralEdge::copy(self : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralEdge::fill(self : BioseqalignstructuralEdge, v : Double) -> BioseqalignstructuralEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralEdge::min(self : BioseqalignstructuralEdge) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralEdge::max(self : BioseqalignstructuralEdge) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralEdge::to_string(self : BioseqalignstructuralEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_path_make(size : Int) -> BioseqalignstructuralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralPath::len(self : BioseqalignstructuralPath) -> Int { self.size }

pub fn BioseqalignstructuralPath::get(self : BioseqalignstructuralPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralPath::set(self : BioseqalignstructuralPath, i : Int, v : Double) -> BioseqalignstructuralPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralPath::sum(self : BioseqalignstructuralPath) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralPath::mean(self : BioseqalignstructuralPath) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralPath::scale(self : BioseqalignstructuralPath, f : Double) -> BioseqalignstructuralPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralPath::add(self : BioseqalignstructuralPath, other : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralPath::copy(self : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralPath::fill(self : BioseqalignstructuralPath, v : Double) -> BioseqalignstructuralPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralPath::min(self : BioseqalignstructuralPath) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralPath::max(self : BioseqalignstructuralPath) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralPath::to_string(self : BioseqalignstructuralPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cluster_make(size : Int) -> BioseqalignstructuralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralCluster::len(self : BioseqalignstructuralCluster) -> Int { self.size }

pub fn BioseqalignstructuralCluster::get(self : BioseqalignstructuralCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralCluster::set(self : BioseqalignstructuralCluster, i : Int, v : Double) -> BioseqalignstructuralCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCluster::sum(self : BioseqalignstructuralCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralCluster::mean(self : BioseqalignstructuralCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralCluster::scale(self : BioseqalignstructuralCluster, f : Double) -> BioseqalignstructuralCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCluster::add(self : BioseqalignstructuralCluster, other : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralCluster::copy(self : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCluster::fill(self : BioseqalignstructuralCluster, v : Double) -> BioseqalignstructuralCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCluster::min(self : BioseqalignstructuralCluster) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralCluster::max(self : BioseqalignstructuralCluster) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralCluster::to_string(self : BioseqalignstructuralCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_model_make(size : Int) -> BioseqalignstructuralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralModel::len(self : BioseqalignstructuralModel) -> Int { self.size }

pub fn BioseqalignstructuralModel::get(self : BioseqalignstructuralModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralModel::set(self : BioseqalignstructuralModel, i : Int, v : Double) -> BioseqalignstructuralModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralModel::sum(self : BioseqalignstructuralModel) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralModel::mean(self : BioseqalignstructuralModel) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralModel::scale(self : BioseqalignstructuralModel, f : Double) -> BioseqalignstructuralModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralModel::add(self : BioseqalignstructuralModel, other : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralModel::copy(self : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralModel::fill(self : BioseqalignstructuralModel, v : Double) -> BioseqalignstructuralModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralModel::min(self : BioseqalignstructuralModel) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralModel::max(self : BioseqalignstructuralModel) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralModel::to_string(self : BioseqalignstructuralModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_layer_make(size : Int) -> BioseqalignstructuralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralLayer::len(self : BioseqalignstructuralLayer) -> Int { self.size }

pub fn BioseqalignstructuralLayer::get(self : BioseqalignstructuralLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralLayer::set(self : BioseqalignstructuralLayer, i : Int, v : Double) -> BioseqalignstructuralLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralLayer::sum(self : BioseqalignstructuralLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralLayer::mean(self : BioseqalignstructuralLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralLayer::scale(self : BioseqalignstructuralLayer, f : Double) -> BioseqalignstructuralLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralLayer::add(self : BioseqalignstructuralLayer, other : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralLayer::copy(self : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralLayer::fill(self : BioseqalignstructuralLayer, v : Double) -> BioseqalignstructuralLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralLayer::min(self : BioseqalignstructuralLayer) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralLayer::max(self : BioseqalignstructuralLayer) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralLayer::to_string(self : BioseqalignstructuralLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_buffer_make(size : Int) -> BioseqalignstructuralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralBuffer::len(self : BioseqalignstructuralBuffer) -> Int { self.size }

pub fn BioseqalignstructuralBuffer::get(self : BioseqalignstructuralBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralBuffer::set(self : BioseqalignstructuralBuffer, i : Int, v : Double) -> BioseqalignstructuralBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralBuffer::sum(self : BioseqalignstructuralBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralBuffer::mean(self : BioseqalignstructuralBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralBuffer::scale(self : BioseqalignstructuralBuffer, f : Double) -> BioseqalignstructuralBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralBuffer::add(self : BioseqalignstructuralBuffer, other : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralBuffer::copy(self : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralBuffer::fill(self : BioseqalignstructuralBuffer, v : Double) -> BioseqalignstructuralBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralBuffer::min(self : BioseqalignstructuralBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralBuffer::max(self : BioseqalignstructuralBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralBuffer::to_string(self : BioseqalignstructuralBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cursor_make(size : Int) -> BioseqalignstructuralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralCursor::len(self : BioseqalignstructuralCursor) -> Int { self.size }

pub fn BioseqalignstructuralCursor::get(self : BioseqalignstructuralCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralCursor::set(self : BioseqalignstructuralCursor, i : Int, v : Double) -> BioseqalignstructuralCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCursor::sum(self : BioseqalignstructuralCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralCursor::mean(self : BioseqalignstructuralCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralCursor::scale(self : BioseqalignstructuralCursor, f : Double) -> BioseqalignstructuralCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCursor::add(self : BioseqalignstructuralCursor, other : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralCursor::copy(self : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCursor::fill(self : BioseqalignstructuralCursor, v : Double) -> BioseqalignstructuralCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralCursor::min(self : BioseqalignstructuralCursor) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralCursor::max(self : BioseqalignstructuralCursor) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralCursor::to_string(self : BioseqalignstructuralCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_view_make(size : Int) -> BioseqalignstructuralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralView::len(self : BioseqalignstructuralView) -> Int { self.size }

pub fn BioseqalignstructuralView::get(self : BioseqalignstructuralView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralView::set(self : BioseqalignstructuralView, i : Int, v : Double) -> BioseqalignstructuralView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralView::sum(self : BioseqalignstructuralView) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralView::mean(self : BioseqalignstructuralView) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralView::scale(self : BioseqalignstructuralView, f : Double) -> BioseqalignstructuralView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralView::add(self : BioseqalignstructuralView, other : BioseqalignstructuralView) -> BioseqalignstructuralView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralView::copy(self : BioseqalignstructuralView) -> BioseqalignstructuralView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralView::fill(self : BioseqalignstructuralView, v : Double) -> BioseqalignstructuralView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralView::min(self : BioseqalignstructuralView) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralView::max(self : BioseqalignstructuralView) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralView::to_string(self : BioseqalignstructuralView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_range_make(size : Int) -> BioseqalignstructuralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralRange::len(self : BioseqalignstructuralRange) -> Int { self.size }

pub fn BioseqalignstructuralRange::get(self : BioseqalignstructuralRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralRange::set(self : BioseqalignstructuralRange, i : Int, v : Double) -> BioseqalignstructuralRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralRange::sum(self : BioseqalignstructuralRange) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralRange::mean(self : BioseqalignstructuralRange) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralRange::scale(self : BioseqalignstructuralRange, f : Double) -> BioseqalignstructuralRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralRange::add(self : BioseqalignstructuralRange, other : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralRange::copy(self : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralRange::fill(self : BioseqalignstructuralRange, v : Double) -> BioseqalignstructuralRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralRange::min(self : BioseqalignstructuralRange) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralRange::max(self : BioseqalignstructuralRange) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralRange::to_string(self : BioseqalignstructuralRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_slice_make(size : Int) -> BioseqalignstructuralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignstructuralSlice::len(self : BioseqalignstructuralSlice) -> Int { self.size }

pub fn BioseqalignstructuralSlice::get(self : BioseqalignstructuralSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignstructuralSlice::set(self : BioseqalignstructuralSlice, i : Int, v : Double) -> BioseqalignstructuralSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralSlice::sum(self : BioseqalignstructuralSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqalignstructuralSlice::mean(self : BioseqalignstructuralSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqalignstructuralSlice::scale(self : BioseqalignstructuralSlice, f : Double) -> BioseqalignstructuralSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralSlice::add(self : BioseqalignstructuralSlice, other : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignstructuralSlice::copy(self : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralSlice::fill(self : BioseqalignstructuralSlice, v : Double) -> BioseqalignstructuralSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignstructuralSlice::min(self : BioseqalignstructuralSlice) -> Double { @_common.min(self.data) }

pub fn BioseqalignstructuralSlice::max(self : BioseqalignstructuralSlice) -> Double { @_common.max(self.data) }

pub fn BioseqalignstructuralSlice::to_string(self : BioseqalignstructuralSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

