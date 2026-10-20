///===
/// extcore/bio_phylo_maximum

pub(all) struct BiophylomaximumPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_maximum_make_point(x : Double, y : Double) -> BiophylomaximumPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_maximum_make_point3(x : Double, y : Double, z : Double) -> BiophylomaximumPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylomaximumPoint::x(self : BiophylomaximumPoint) -> Double { self.x }

pub fn BiophylomaximumPoint::y(self : BiophylomaximumPoint) -> Double { self.y }

pub fn BiophylomaximumPoint::z(self : BiophylomaximumPoint) -> Double { self.z }

pub fn BiophylomaximumPoint::label(self : BiophylomaximumPoint) -> Int { self.label }

pub fn BiophylomaximumPoint::dist(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylomaximumPoint::add(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylomaximumPoint::sub(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylomaximumPoint::scale(self : BiophylomaximumPoint, s : Double) -> BiophylomaximumPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylomaximumPoint::dot(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylomaximumPoint::cross(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylomaximumPoint::norm(self : BiophylomaximumPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylomaximumPoint::normalize(self : BiophylomaximumPoint) -> BiophylomaximumPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylomaximumPoint::negate(self : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylomaximumPoint::mid(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylomaximumPoint::lerp(self : BiophylomaximumPoint, other : BiophylomaximumPoint, t : Double) -> BiophylomaximumPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylomaximumPoint::to_string(self : BiophylomaximumPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylomaximumSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_maximum_make_series(vals : Array[Double], name : String) -> BiophylomaximumSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylomaximumSeries::len(self : BiophylomaximumSeries) -> Int { self.vals.length() }

pub fn BiophylomaximumSeries::sum(self : BiophylomaximumSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylomaximumSeries::mean(self : BiophylomaximumSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylomaximumSeries::min(self : BiophylomaximumSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylomaximumSeries::max(self : BiophylomaximumSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylomaximumSeries::range(self : BiophylomaximumSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylomaximumSeries::variance(self : BiophylomaximumSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylomaximumSeries::std(self : BiophylomaximumSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylomaximumSeries::median(self : BiophylomaximumSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylomaximumSeries::scale(self : BiophylomaximumSeries, f : Double) -> BiophylomaximumSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::add(self : BiophylomaximumSeries, other : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::sub(self : BiophylomaximumSeries, other : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::normalize(self : BiophylomaximumSeries) -> BiophylomaximumSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylomaximumSeries::cumsum(self : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylomaximumSeries::to_string(self : BiophylomaximumSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylomaximumMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_maximum_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylomaximumMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_maximum_matrix_identity(n : Int) -> BiophylomaximumMatrix {
  let m = bio_phylo_maximum_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylomaximumMatrix::get(self : BiophylomaximumMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylomaximumMatrix::transpose(self : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylomaximumMatrix::add(self : BiophylomaximumMatrix, other : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_maximum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylomaximumMatrix::scale(self : BiophylomaximumMatrix, s : Double) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylomaximumMatrix::multiply(self : BiophylomaximumMatrix, other : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if self.cols != other.rows { return bio_phylo_maximum_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_maximum_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylomaximumMatrix::trace(self : BiophylomaximumMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylomaximumMatrix::det(self : BiophylomaximumMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylomaximumMatrix::norm(self : BiophylomaximumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylomaximumMatrix::to_string(self : BiophylomaximumMatrix) -> String {
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

pub(all) struct BiophylomaximumVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_maximum_make_vector(comps : Array[Double]) -> BiophylomaximumVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_maximum_vector_zero(dim : Int) -> BiophylomaximumVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylomaximumVector::add(self : BiophylomaximumVector, other : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylomaximumVector::sub(self : BiophylomaximumVector, other : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylomaximumVector::scale(self : BiophylomaximumVector, s : Double) -> BiophylomaximumVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylomaximumVector::dot(self : BiophylomaximumVector, other : BiophylomaximumVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylomaximumVector::norm(self : BiophylomaximumVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylomaximumVector::normalize(self : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylomaximumVector::dist(self : BiophylomaximumVector, other : BiophylomaximumVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylomaximumVector::to_string(self : BiophylomaximumVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylomaximumFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_frame_make(size : Int) -> BiophylomaximumFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumFrame::len(self : BiophylomaximumFrame) -> Int { self.size }

pub fn BiophylomaximumFrame::get(self : BiophylomaximumFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumFrame::set(self : BiophylomaximumFrame, i : Int, v : Double) -> BiophylomaximumFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumFrame::sum(self : BiophylomaximumFrame) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumFrame::mean(self : BiophylomaximumFrame) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumFrame::scale(self : BiophylomaximumFrame, f : Double) -> BiophylomaximumFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumFrame::add(self : BiophylomaximumFrame, other : BiophylomaximumFrame) -> BiophylomaximumFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumFrame::copy(self : BiophylomaximumFrame) -> BiophylomaximumFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumFrame::fill(self : BiophylomaximumFrame, v : Double) -> BiophylomaximumFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumFrame::min(self : BiophylomaximumFrame) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumFrame::max(self : BiophylomaximumFrame) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumFrame::to_string(self : BiophylomaximumFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_table_make(size : Int) -> BiophylomaximumTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumTable::len(self : BiophylomaximumTable) -> Int { self.size }

pub fn BiophylomaximumTable::get(self : BiophylomaximumTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumTable::set(self : BiophylomaximumTable, i : Int, v : Double) -> BiophylomaximumTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumTable::sum(self : BiophylomaximumTable) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumTable::mean(self : BiophylomaximumTable) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumTable::scale(self : BiophylomaximumTable, f : Double) -> BiophylomaximumTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumTable::add(self : BiophylomaximumTable, other : BiophylomaximumTable) -> BiophylomaximumTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumTable::copy(self : BiophylomaximumTable) -> BiophylomaximumTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumTable::fill(self : BiophylomaximumTable, v : Double) -> BiophylomaximumTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumTable::min(self : BiophylomaximumTable) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumTable::max(self : BiophylomaximumTable) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumTable::to_string(self : BiophylomaximumTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_graphn_make(size : Int) -> BiophylomaximumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumGraphN::len(self : BiophylomaximumGraphN) -> Int { self.size }

pub fn BiophylomaximumGraphN::get(self : BiophylomaximumGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumGraphN::set(self : BiophylomaximumGraphN, i : Int, v : Double) -> BiophylomaximumGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumGraphN::sum(self : BiophylomaximumGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumGraphN::mean(self : BiophylomaximumGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumGraphN::scale(self : BiophylomaximumGraphN, f : Double) -> BiophylomaximumGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumGraphN::add(self : BiophylomaximumGraphN, other : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumGraphN::copy(self : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumGraphN::fill(self : BiophylomaximumGraphN, v : Double) -> BiophylomaximumGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumGraphN::min(self : BiophylomaximumGraphN) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumGraphN::max(self : BiophylomaximumGraphN) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumGraphN::to_string(self : BiophylomaximumGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_node_make(size : Int) -> BiophylomaximumNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumNode::len(self : BiophylomaximumNode) -> Int { self.size }

pub fn BiophylomaximumNode::get(self : BiophylomaximumNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumNode::set(self : BiophylomaximumNode, i : Int, v : Double) -> BiophylomaximumNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumNode::sum(self : BiophylomaximumNode) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumNode::mean(self : BiophylomaximumNode) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumNode::scale(self : BiophylomaximumNode, f : Double) -> BiophylomaximumNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumNode::add(self : BiophylomaximumNode, other : BiophylomaximumNode) -> BiophylomaximumNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumNode::copy(self : BiophylomaximumNode) -> BiophylomaximumNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumNode::fill(self : BiophylomaximumNode, v : Double) -> BiophylomaximumNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumNode::min(self : BiophylomaximumNode) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumNode::max(self : BiophylomaximumNode) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumNode::to_string(self : BiophylomaximumNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_edge_make(size : Int) -> BiophylomaximumEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumEdge::len(self : BiophylomaximumEdge) -> Int { self.size }

pub fn BiophylomaximumEdge::get(self : BiophylomaximumEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumEdge::set(self : BiophylomaximumEdge, i : Int, v : Double) -> BiophylomaximumEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumEdge::sum(self : BiophylomaximumEdge) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumEdge::mean(self : BiophylomaximumEdge) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumEdge::scale(self : BiophylomaximumEdge, f : Double) -> BiophylomaximumEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumEdge::add(self : BiophylomaximumEdge, other : BiophylomaximumEdge) -> BiophylomaximumEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumEdge::copy(self : BiophylomaximumEdge) -> BiophylomaximumEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumEdge::fill(self : BiophylomaximumEdge, v : Double) -> BiophylomaximumEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumEdge::min(self : BiophylomaximumEdge) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumEdge::max(self : BiophylomaximumEdge) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumEdge::to_string(self : BiophylomaximumEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_path_make(size : Int) -> BiophylomaximumPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumPath::len(self : BiophylomaximumPath) -> Int { self.size }

pub fn BiophylomaximumPath::get(self : BiophylomaximumPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumPath::set(self : BiophylomaximumPath, i : Int, v : Double) -> BiophylomaximumPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumPath::sum(self : BiophylomaximumPath) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumPath::mean(self : BiophylomaximumPath) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumPath::scale(self : BiophylomaximumPath, f : Double) -> BiophylomaximumPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumPath::add(self : BiophylomaximumPath, other : BiophylomaximumPath) -> BiophylomaximumPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumPath::copy(self : BiophylomaximumPath) -> BiophylomaximumPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumPath::fill(self : BiophylomaximumPath, v : Double) -> BiophylomaximumPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumPath::min(self : BiophylomaximumPath) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumPath::max(self : BiophylomaximumPath) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumPath::to_string(self : BiophylomaximumPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cluster_make(size : Int) -> BiophylomaximumCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumCluster::len(self : BiophylomaximumCluster) -> Int { self.size }

pub fn BiophylomaximumCluster::get(self : BiophylomaximumCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumCluster::set(self : BiophylomaximumCluster, i : Int, v : Double) -> BiophylomaximumCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCluster::sum(self : BiophylomaximumCluster) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumCluster::mean(self : BiophylomaximumCluster) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumCluster::scale(self : BiophylomaximumCluster, f : Double) -> BiophylomaximumCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCluster::add(self : BiophylomaximumCluster, other : BiophylomaximumCluster) -> BiophylomaximumCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumCluster::copy(self : BiophylomaximumCluster) -> BiophylomaximumCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCluster::fill(self : BiophylomaximumCluster, v : Double) -> BiophylomaximumCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCluster::min(self : BiophylomaximumCluster) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumCluster::max(self : BiophylomaximumCluster) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumCluster::to_string(self : BiophylomaximumCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_model_make(size : Int) -> BiophylomaximumModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumModel::len(self : BiophylomaximumModel) -> Int { self.size }

pub fn BiophylomaximumModel::get(self : BiophylomaximumModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumModel::set(self : BiophylomaximumModel, i : Int, v : Double) -> BiophylomaximumModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumModel::sum(self : BiophylomaximumModel) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumModel::mean(self : BiophylomaximumModel) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumModel::scale(self : BiophylomaximumModel, f : Double) -> BiophylomaximumModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumModel::add(self : BiophylomaximumModel, other : BiophylomaximumModel) -> BiophylomaximumModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumModel::copy(self : BiophylomaximumModel) -> BiophylomaximumModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumModel::fill(self : BiophylomaximumModel, v : Double) -> BiophylomaximumModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumModel::min(self : BiophylomaximumModel) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumModel::max(self : BiophylomaximumModel) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumModel::to_string(self : BiophylomaximumModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_layer_make(size : Int) -> BiophylomaximumLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumLayer::len(self : BiophylomaximumLayer) -> Int { self.size }

pub fn BiophylomaximumLayer::get(self : BiophylomaximumLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumLayer::set(self : BiophylomaximumLayer, i : Int, v : Double) -> BiophylomaximumLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumLayer::sum(self : BiophylomaximumLayer) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumLayer::mean(self : BiophylomaximumLayer) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumLayer::scale(self : BiophylomaximumLayer, f : Double) -> BiophylomaximumLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumLayer::add(self : BiophylomaximumLayer, other : BiophylomaximumLayer) -> BiophylomaximumLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumLayer::copy(self : BiophylomaximumLayer) -> BiophylomaximumLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumLayer::fill(self : BiophylomaximumLayer, v : Double) -> BiophylomaximumLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumLayer::min(self : BiophylomaximumLayer) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumLayer::max(self : BiophylomaximumLayer) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumLayer::to_string(self : BiophylomaximumLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_buffer_make(size : Int) -> BiophylomaximumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumBuffer::len(self : BiophylomaximumBuffer) -> Int { self.size }

pub fn BiophylomaximumBuffer::get(self : BiophylomaximumBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumBuffer::set(self : BiophylomaximumBuffer, i : Int, v : Double) -> BiophylomaximumBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumBuffer::sum(self : BiophylomaximumBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumBuffer::mean(self : BiophylomaximumBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumBuffer::scale(self : BiophylomaximumBuffer, f : Double) -> BiophylomaximumBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumBuffer::add(self : BiophylomaximumBuffer, other : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumBuffer::copy(self : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumBuffer::fill(self : BiophylomaximumBuffer, v : Double) -> BiophylomaximumBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumBuffer::min(self : BiophylomaximumBuffer) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumBuffer::max(self : BiophylomaximumBuffer) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumBuffer::to_string(self : BiophylomaximumBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cursor_make(size : Int) -> BiophylomaximumCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumCursor::len(self : BiophylomaximumCursor) -> Int { self.size }

pub fn BiophylomaximumCursor::get(self : BiophylomaximumCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumCursor::set(self : BiophylomaximumCursor, i : Int, v : Double) -> BiophylomaximumCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCursor::sum(self : BiophylomaximumCursor) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumCursor::mean(self : BiophylomaximumCursor) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumCursor::scale(self : BiophylomaximumCursor, f : Double) -> BiophylomaximumCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCursor::add(self : BiophylomaximumCursor, other : BiophylomaximumCursor) -> BiophylomaximumCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumCursor::copy(self : BiophylomaximumCursor) -> BiophylomaximumCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCursor::fill(self : BiophylomaximumCursor, v : Double) -> BiophylomaximumCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumCursor::min(self : BiophylomaximumCursor) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumCursor::max(self : BiophylomaximumCursor) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumCursor::to_string(self : BiophylomaximumCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_view_make(size : Int) -> BiophylomaximumView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumView::len(self : BiophylomaximumView) -> Int { self.size }

pub fn BiophylomaximumView::get(self : BiophylomaximumView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumView::set(self : BiophylomaximumView, i : Int, v : Double) -> BiophylomaximumView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumView::sum(self : BiophylomaximumView) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumView::mean(self : BiophylomaximumView) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumView::scale(self : BiophylomaximumView, f : Double) -> BiophylomaximumView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumView::add(self : BiophylomaximumView, other : BiophylomaximumView) -> BiophylomaximumView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumView::copy(self : BiophylomaximumView) -> BiophylomaximumView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumView::fill(self : BiophylomaximumView, v : Double) -> BiophylomaximumView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumView::min(self : BiophylomaximumView) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumView::max(self : BiophylomaximumView) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumView::to_string(self : BiophylomaximumView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_range_make(size : Int) -> BiophylomaximumRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumRange::len(self : BiophylomaximumRange) -> Int { self.size }

pub fn BiophylomaximumRange::get(self : BiophylomaximumRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumRange::set(self : BiophylomaximumRange, i : Int, v : Double) -> BiophylomaximumRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumRange::sum(self : BiophylomaximumRange) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumRange::mean(self : BiophylomaximumRange) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumRange::scale(self : BiophylomaximumRange, f : Double) -> BiophylomaximumRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumRange::add(self : BiophylomaximumRange, other : BiophylomaximumRange) -> BiophylomaximumRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumRange::copy(self : BiophylomaximumRange) -> BiophylomaximumRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumRange::fill(self : BiophylomaximumRange, v : Double) -> BiophylomaximumRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumRange::min(self : BiophylomaximumRange) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumRange::max(self : BiophylomaximumRange) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumRange::to_string(self : BiophylomaximumRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_slice_make(size : Int) -> BiophylomaximumSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylomaximumSlice::len(self : BiophylomaximumSlice) -> Int { self.size }

pub fn BiophylomaximumSlice::get(self : BiophylomaximumSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylomaximumSlice::set(self : BiophylomaximumSlice, i : Int, v : Double) -> BiophylomaximumSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylomaximumSlice::sum(self : BiophylomaximumSlice) -> Double { @_common.sum(self.data) }

pub fn BiophylomaximumSlice::mean(self : BiophylomaximumSlice) -> Double { @_common.mean(self.data) }

pub fn BiophylomaximumSlice::scale(self : BiophylomaximumSlice, f : Double) -> BiophylomaximumSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumSlice::add(self : BiophylomaximumSlice, other : BiophylomaximumSlice) -> BiophylomaximumSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylomaximumSlice::copy(self : BiophylomaximumSlice) -> BiophylomaximumSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumSlice::fill(self : BiophylomaximumSlice, v : Double) -> BiophylomaximumSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylomaximumSlice::min(self : BiophylomaximumSlice) -> Double { @_common.min(self.data) }

pub fn BiophylomaximumSlice::max(self : BiophylomaximumSlice) -> Double { @_common.max(self.data) }

pub fn BiophylomaximumSlice::to_string(self : BiophylomaximumSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

