///===
/// extcore/bio_seq_align_semi

pub(all) struct BioseqalignsemiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_semi_make_point(x : Double, y : Double) -> BioseqalignsemiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_semi_make_point3(x : Double, y : Double, z : Double) -> BioseqalignsemiPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignsemiPoint::x(self : BioseqalignsemiPoint) -> Double { self.x }

pub fn BioseqalignsemiPoint::y(self : BioseqalignsemiPoint) -> Double { self.y }

pub fn BioseqalignsemiPoint::z(self : BioseqalignsemiPoint) -> Double { self.z }

pub fn BioseqalignsemiPoint::label(self : BioseqalignsemiPoint) -> Int { self.label }

pub fn BioseqalignsemiPoint::dist(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignsemiPoint::add(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignsemiPoint::sub(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignsemiPoint::scale(self : BioseqalignsemiPoint, s : Double) -> BioseqalignsemiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignsemiPoint::dot(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignsemiPoint::cross(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignsemiPoint::norm(self : BioseqalignsemiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignsemiPoint::normalize(self : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignsemiPoint::negate(self : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignsemiPoint::mid(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignsemiPoint::lerp(self : BioseqalignsemiPoint, other : BioseqalignsemiPoint, t : Double) -> BioseqalignsemiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignsemiPoint::to_string(self : BioseqalignsemiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignsemiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_semi_make_series(vals : Array[Double], name : String) -> BioseqalignsemiSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignsemiSeries::len(self : BioseqalignsemiSeries) -> Int { self.vals.length() }

pub fn BioseqalignsemiSeries::sum(self : BioseqalignsemiSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignsemiSeries::mean(self : BioseqalignsemiSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignsemiSeries::min(self : BioseqalignsemiSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignsemiSeries::max(self : BioseqalignsemiSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignsemiSeries::range(self : BioseqalignsemiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignsemiSeries::variance(self : BioseqalignsemiSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignsemiSeries::std(self : BioseqalignsemiSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignsemiSeries::median(self : BioseqalignsemiSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignsemiSeries::scale(self : BioseqalignsemiSeries, f : Double) -> BioseqalignsemiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignsemiSeries::add(self : BioseqalignsemiSeries, other : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignsemiSeries::sub(self : BioseqalignsemiSeries, other : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignsemiSeries::normalize(self : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignsemiSeries::cumsum(self : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignsemiSeries::to_string(self : BioseqalignsemiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignsemiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_semi_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignsemiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_semi_matrix_identity(n : Int) -> BioseqalignsemiMatrix {
  let m = bio_seq_align_semi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignsemiMatrix::get(self : BioseqalignsemiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignsemiMatrix::transpose(self : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  let result = bio_seq_align_semi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignsemiMatrix::add(self : BioseqalignsemiMatrix, other : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_semi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignsemiMatrix::scale(self : BioseqalignsemiMatrix, s : Double) -> BioseqalignsemiMatrix {
  let result = bio_seq_align_semi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignsemiMatrix::multiply(self : BioseqalignsemiMatrix, other : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  if self.cols != other.rows { return bio_seq_align_semi_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_semi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqalignsemiMatrix::trace(self : BioseqalignsemiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignsemiMatrix::det(self : BioseqalignsemiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignsemiMatrix::norm(self : BioseqalignsemiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignsemiMatrix::to_string(self : BioseqalignsemiMatrix) -> String {
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

pub(all) struct BioseqalignsemiVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_semi_make_vector(comps : Array[Double]) -> BioseqalignsemiVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_semi_vector_zero(dim : Int) -> BioseqalignsemiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignsemiVector::add(self : BioseqalignsemiVector, other : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignsemiVector::sub(self : BioseqalignsemiVector, other : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignsemiVector::scale(self : BioseqalignsemiVector, s : Double) -> BioseqalignsemiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignsemiVector::dot(self : BioseqalignsemiVector, other : BioseqalignsemiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignsemiVector::norm(self : BioseqalignsemiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignsemiVector::normalize(self : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignsemiVector::dist(self : BioseqalignsemiVector, other : BioseqalignsemiVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignsemiVector::to_string(self : BioseqalignsemiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignsemiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_frame_make(size : Int) -> BioseqalignsemiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiFrame::len(self : BioseqalignsemiFrame) -> Int { self.size }

pub fn BioseqalignsemiFrame::get(self : BioseqalignsemiFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiFrame::set(self : BioseqalignsemiFrame, i : Int, v : Double) -> BioseqalignsemiFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiFrame::sum(self : BioseqalignsemiFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiFrame::mean(self : BioseqalignsemiFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiFrame::scale(self : BioseqalignsemiFrame, f : Double) -> BioseqalignsemiFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiFrame::add(self : BioseqalignsemiFrame, other : BioseqalignsemiFrame) -> BioseqalignsemiFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiFrame::copy(self : BioseqalignsemiFrame) -> BioseqalignsemiFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiFrame::fill(self : BioseqalignsemiFrame, v : Double) -> BioseqalignsemiFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiFrame::min(self : BioseqalignsemiFrame) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiFrame::max(self : BioseqalignsemiFrame) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiFrame::to_string(self : BioseqalignsemiFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_table_make(size : Int) -> BioseqalignsemiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiTable::len(self : BioseqalignsemiTable) -> Int { self.size }

pub fn BioseqalignsemiTable::get(self : BioseqalignsemiTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiTable::set(self : BioseqalignsemiTable, i : Int, v : Double) -> BioseqalignsemiTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiTable::sum(self : BioseqalignsemiTable) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiTable::mean(self : BioseqalignsemiTable) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiTable::scale(self : BioseqalignsemiTable, f : Double) -> BioseqalignsemiTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiTable::add(self : BioseqalignsemiTable, other : BioseqalignsemiTable) -> BioseqalignsemiTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiTable::copy(self : BioseqalignsemiTable) -> BioseqalignsemiTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiTable::fill(self : BioseqalignsemiTable, v : Double) -> BioseqalignsemiTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiTable::min(self : BioseqalignsemiTable) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiTable::max(self : BioseqalignsemiTable) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiTable::to_string(self : BioseqalignsemiTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_graphn_make(size : Int) -> BioseqalignsemiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiGraphN::len(self : BioseqalignsemiGraphN) -> Int { self.size }

pub fn BioseqalignsemiGraphN::get(self : BioseqalignsemiGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiGraphN::set(self : BioseqalignsemiGraphN, i : Int, v : Double) -> BioseqalignsemiGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiGraphN::sum(self : BioseqalignsemiGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiGraphN::mean(self : BioseqalignsemiGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiGraphN::scale(self : BioseqalignsemiGraphN, f : Double) -> BioseqalignsemiGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiGraphN::add(self : BioseqalignsemiGraphN, other : BioseqalignsemiGraphN) -> BioseqalignsemiGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiGraphN::copy(self : BioseqalignsemiGraphN) -> BioseqalignsemiGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiGraphN::fill(self : BioseqalignsemiGraphN, v : Double) -> BioseqalignsemiGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiGraphN::min(self : BioseqalignsemiGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiGraphN::max(self : BioseqalignsemiGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiGraphN::to_string(self : BioseqalignsemiGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_node_make(size : Int) -> BioseqalignsemiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiNode::len(self : BioseqalignsemiNode) -> Int { self.size }

pub fn BioseqalignsemiNode::get(self : BioseqalignsemiNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiNode::set(self : BioseqalignsemiNode, i : Int, v : Double) -> BioseqalignsemiNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiNode::sum(self : BioseqalignsemiNode) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiNode::mean(self : BioseqalignsemiNode) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiNode::scale(self : BioseqalignsemiNode, f : Double) -> BioseqalignsemiNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiNode::add(self : BioseqalignsemiNode, other : BioseqalignsemiNode) -> BioseqalignsemiNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiNode::copy(self : BioseqalignsemiNode) -> BioseqalignsemiNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiNode::fill(self : BioseqalignsemiNode, v : Double) -> BioseqalignsemiNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiNode::min(self : BioseqalignsemiNode) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiNode::max(self : BioseqalignsemiNode) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiNode::to_string(self : BioseqalignsemiNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_edge_make(size : Int) -> BioseqalignsemiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiEdge::len(self : BioseqalignsemiEdge) -> Int { self.size }

pub fn BioseqalignsemiEdge::get(self : BioseqalignsemiEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiEdge::set(self : BioseqalignsemiEdge, i : Int, v : Double) -> BioseqalignsemiEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiEdge::sum(self : BioseqalignsemiEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiEdge::mean(self : BioseqalignsemiEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiEdge::scale(self : BioseqalignsemiEdge, f : Double) -> BioseqalignsemiEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiEdge::add(self : BioseqalignsemiEdge, other : BioseqalignsemiEdge) -> BioseqalignsemiEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiEdge::copy(self : BioseqalignsemiEdge) -> BioseqalignsemiEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiEdge::fill(self : BioseqalignsemiEdge, v : Double) -> BioseqalignsemiEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiEdge::min(self : BioseqalignsemiEdge) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiEdge::max(self : BioseqalignsemiEdge) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiEdge::to_string(self : BioseqalignsemiEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_path_make(size : Int) -> BioseqalignsemiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiPath::len(self : BioseqalignsemiPath) -> Int { self.size }

pub fn BioseqalignsemiPath::get(self : BioseqalignsemiPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiPath::set(self : BioseqalignsemiPath, i : Int, v : Double) -> BioseqalignsemiPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiPath::sum(self : BioseqalignsemiPath) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiPath::mean(self : BioseqalignsemiPath) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiPath::scale(self : BioseqalignsemiPath, f : Double) -> BioseqalignsemiPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiPath::add(self : BioseqalignsemiPath, other : BioseqalignsemiPath) -> BioseqalignsemiPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiPath::copy(self : BioseqalignsemiPath) -> BioseqalignsemiPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiPath::fill(self : BioseqalignsemiPath, v : Double) -> BioseqalignsemiPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiPath::min(self : BioseqalignsemiPath) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiPath::max(self : BioseqalignsemiPath) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiPath::to_string(self : BioseqalignsemiPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_cluster_make(size : Int) -> BioseqalignsemiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiCluster::len(self : BioseqalignsemiCluster) -> Int { self.size }

pub fn BioseqalignsemiCluster::get(self : BioseqalignsemiCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiCluster::set(self : BioseqalignsemiCluster, i : Int, v : Double) -> BioseqalignsemiCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCluster::sum(self : BioseqalignsemiCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiCluster::mean(self : BioseqalignsemiCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiCluster::scale(self : BioseqalignsemiCluster, f : Double) -> BioseqalignsemiCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCluster::add(self : BioseqalignsemiCluster, other : BioseqalignsemiCluster) -> BioseqalignsemiCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiCluster::copy(self : BioseqalignsemiCluster) -> BioseqalignsemiCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCluster::fill(self : BioseqalignsemiCluster, v : Double) -> BioseqalignsemiCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCluster::min(self : BioseqalignsemiCluster) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiCluster::max(self : BioseqalignsemiCluster) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiCluster::to_string(self : BioseqalignsemiCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_model_make(size : Int) -> BioseqalignsemiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiModel::len(self : BioseqalignsemiModel) -> Int { self.size }

pub fn BioseqalignsemiModel::get(self : BioseqalignsemiModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiModel::set(self : BioseqalignsemiModel, i : Int, v : Double) -> BioseqalignsemiModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiModel::sum(self : BioseqalignsemiModel) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiModel::mean(self : BioseqalignsemiModel) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiModel::scale(self : BioseqalignsemiModel, f : Double) -> BioseqalignsemiModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiModel::add(self : BioseqalignsemiModel, other : BioseqalignsemiModel) -> BioseqalignsemiModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiModel::copy(self : BioseqalignsemiModel) -> BioseqalignsemiModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiModel::fill(self : BioseqalignsemiModel, v : Double) -> BioseqalignsemiModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiModel::min(self : BioseqalignsemiModel) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiModel::max(self : BioseqalignsemiModel) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiModel::to_string(self : BioseqalignsemiModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_layer_make(size : Int) -> BioseqalignsemiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiLayer::len(self : BioseqalignsemiLayer) -> Int { self.size }

pub fn BioseqalignsemiLayer::get(self : BioseqalignsemiLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiLayer::set(self : BioseqalignsemiLayer, i : Int, v : Double) -> BioseqalignsemiLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiLayer::sum(self : BioseqalignsemiLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiLayer::mean(self : BioseqalignsemiLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiLayer::scale(self : BioseqalignsemiLayer, f : Double) -> BioseqalignsemiLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiLayer::add(self : BioseqalignsemiLayer, other : BioseqalignsemiLayer) -> BioseqalignsemiLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiLayer::copy(self : BioseqalignsemiLayer) -> BioseqalignsemiLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiLayer::fill(self : BioseqalignsemiLayer, v : Double) -> BioseqalignsemiLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiLayer::min(self : BioseqalignsemiLayer) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiLayer::max(self : BioseqalignsemiLayer) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiLayer::to_string(self : BioseqalignsemiLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_buffer_make(size : Int) -> BioseqalignsemiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiBuffer::len(self : BioseqalignsemiBuffer) -> Int { self.size }

pub fn BioseqalignsemiBuffer::get(self : BioseqalignsemiBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiBuffer::set(self : BioseqalignsemiBuffer, i : Int, v : Double) -> BioseqalignsemiBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiBuffer::sum(self : BioseqalignsemiBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiBuffer::mean(self : BioseqalignsemiBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiBuffer::scale(self : BioseqalignsemiBuffer, f : Double) -> BioseqalignsemiBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiBuffer::add(self : BioseqalignsemiBuffer, other : BioseqalignsemiBuffer) -> BioseqalignsemiBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiBuffer::copy(self : BioseqalignsemiBuffer) -> BioseqalignsemiBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiBuffer::fill(self : BioseqalignsemiBuffer, v : Double) -> BioseqalignsemiBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiBuffer::min(self : BioseqalignsemiBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiBuffer::max(self : BioseqalignsemiBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiBuffer::to_string(self : BioseqalignsemiBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_cursor_make(size : Int) -> BioseqalignsemiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiCursor::len(self : BioseqalignsemiCursor) -> Int { self.size }

pub fn BioseqalignsemiCursor::get(self : BioseqalignsemiCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiCursor::set(self : BioseqalignsemiCursor, i : Int, v : Double) -> BioseqalignsemiCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCursor::sum(self : BioseqalignsemiCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiCursor::mean(self : BioseqalignsemiCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiCursor::scale(self : BioseqalignsemiCursor, f : Double) -> BioseqalignsemiCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCursor::add(self : BioseqalignsemiCursor, other : BioseqalignsemiCursor) -> BioseqalignsemiCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiCursor::copy(self : BioseqalignsemiCursor) -> BioseqalignsemiCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCursor::fill(self : BioseqalignsemiCursor, v : Double) -> BioseqalignsemiCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiCursor::min(self : BioseqalignsemiCursor) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiCursor::max(self : BioseqalignsemiCursor) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiCursor::to_string(self : BioseqalignsemiCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_view_make(size : Int) -> BioseqalignsemiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiView::len(self : BioseqalignsemiView) -> Int { self.size }

pub fn BioseqalignsemiView::get(self : BioseqalignsemiView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiView::set(self : BioseqalignsemiView, i : Int, v : Double) -> BioseqalignsemiView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiView::sum(self : BioseqalignsemiView) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiView::mean(self : BioseqalignsemiView) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiView::scale(self : BioseqalignsemiView, f : Double) -> BioseqalignsemiView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiView::add(self : BioseqalignsemiView, other : BioseqalignsemiView) -> BioseqalignsemiView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiView::copy(self : BioseqalignsemiView) -> BioseqalignsemiView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiView::fill(self : BioseqalignsemiView, v : Double) -> BioseqalignsemiView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiView::min(self : BioseqalignsemiView) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiView::max(self : BioseqalignsemiView) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiView::to_string(self : BioseqalignsemiView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_range_make(size : Int) -> BioseqalignsemiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiRange::len(self : BioseqalignsemiRange) -> Int { self.size }

pub fn BioseqalignsemiRange::get(self : BioseqalignsemiRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiRange::set(self : BioseqalignsemiRange, i : Int, v : Double) -> BioseqalignsemiRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiRange::sum(self : BioseqalignsemiRange) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiRange::mean(self : BioseqalignsemiRange) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiRange::scale(self : BioseqalignsemiRange, f : Double) -> BioseqalignsemiRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiRange::add(self : BioseqalignsemiRange, other : BioseqalignsemiRange) -> BioseqalignsemiRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiRange::copy(self : BioseqalignsemiRange) -> BioseqalignsemiRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiRange::fill(self : BioseqalignsemiRange, v : Double) -> BioseqalignsemiRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiRange::min(self : BioseqalignsemiRange) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiRange::max(self : BioseqalignsemiRange) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiRange::to_string(self : BioseqalignsemiRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_slice_make(size : Int) -> BioseqalignsemiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignsemiSlice::len(self : BioseqalignsemiSlice) -> Int { self.size }

pub fn BioseqalignsemiSlice::get(self : BioseqalignsemiSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignsemiSlice::set(self : BioseqalignsemiSlice, i : Int, v : Double) -> BioseqalignsemiSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiSlice::sum(self : BioseqalignsemiSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqalignsemiSlice::mean(self : BioseqalignsemiSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqalignsemiSlice::scale(self : BioseqalignsemiSlice, f : Double) -> BioseqalignsemiSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiSlice::add(self : BioseqalignsemiSlice, other : BioseqalignsemiSlice) -> BioseqalignsemiSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignsemiSlice::copy(self : BioseqalignsemiSlice) -> BioseqalignsemiSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiSlice::fill(self : BioseqalignsemiSlice, v : Double) -> BioseqalignsemiSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignsemiSlice::min(self : BioseqalignsemiSlice) -> Double { @_common.min(self.data) }

pub fn BioseqalignsemiSlice::max(self : BioseqalignsemiSlice) -> Double { @_common.max(self.data) }

pub fn BioseqalignsemiSlice::to_string(self : BioseqalignsemiSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

