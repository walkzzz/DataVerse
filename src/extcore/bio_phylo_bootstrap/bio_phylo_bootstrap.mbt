///===
/// extcore/bio_phylo_bootstrap

pub(all) struct BiophylobootstrapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_bootstrap_make_point(x : Double, y : Double) -> BiophylobootstrapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_bootstrap_make_point3(x : Double, y : Double, z : Double) -> BiophylobootstrapPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylobootstrapPoint::x(self : BiophylobootstrapPoint) -> Double { self.x }

pub fn BiophylobootstrapPoint::y(self : BiophylobootstrapPoint) -> Double { self.y }

pub fn BiophylobootstrapPoint::z(self : BiophylobootstrapPoint) -> Double { self.z }

pub fn BiophylobootstrapPoint::label(self : BiophylobootstrapPoint) -> Int { self.label }

pub fn BiophylobootstrapPoint::dist(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylobootstrapPoint::add(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylobootstrapPoint::sub(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylobootstrapPoint::scale(self : BiophylobootstrapPoint, s : Double) -> BiophylobootstrapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylobootstrapPoint::dot(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylobootstrapPoint::cross(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylobootstrapPoint::norm(self : BiophylobootstrapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylobootstrapPoint::normalize(self : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobootstrapPoint::negate(self : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylobootstrapPoint::mid(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylobootstrapPoint::lerp(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint, t : Double) -> BiophylobootstrapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylobootstrapPoint::to_string(self : BiophylobootstrapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylobootstrapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_bootstrap_make_series(vals : Array[Double], name : String) -> BiophylobootstrapSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylobootstrapSeries::len(self : BiophylobootstrapSeries) -> Int { self.vals.length() }

pub fn BiophylobootstrapSeries::sum(self : BiophylobootstrapSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylobootstrapSeries::mean(self : BiophylobootstrapSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylobootstrapSeries::min(self : BiophylobootstrapSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylobootstrapSeries::max(self : BiophylobootstrapSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylobootstrapSeries::range(self : BiophylobootstrapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylobootstrapSeries::variance(self : BiophylobootstrapSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylobootstrapSeries::std(self : BiophylobootstrapSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylobootstrapSeries::median(self : BiophylobootstrapSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylobootstrapSeries::scale(self : BiophylobootstrapSeries, f : Double) -> BiophylobootstrapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::add(self : BiophylobootstrapSeries, other : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::sub(self : BiophylobootstrapSeries, other : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::normalize(self : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylobootstrapSeries::cumsum(self : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylobootstrapSeries::to_string(self : BiophylobootstrapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobootstrapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_bootstrap_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylobootstrapMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_phylo_bootstrap_matrix_identity(n : Int) -> BiophylobootstrapMatrix {
  let m = bio_phylo_bootstrap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylobootstrapMatrix::get(self : BiophylobootstrapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylobootstrapMatrix::transpose(self : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylobootstrapMatrix::add(self : BiophylobootstrapMatrix, other : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_bootstrap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylobootstrapMatrix::scale(self : BiophylobootstrapMatrix, s : Double) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylobootstrapMatrix::multiply(self : BiophylobootstrapMatrix, other : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if self.cols != other.rows { return bio_phylo_bootstrap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_bootstrap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BiophylobootstrapMatrix::trace(self : BiophylobootstrapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylobootstrapMatrix::det(self : BiophylobootstrapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylobootstrapMatrix::norm(self : BiophylobootstrapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylobootstrapMatrix::to_string(self : BiophylobootstrapMatrix) -> String {
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

pub(all) struct BiophylobootstrapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_bootstrap_make_vector(comps : Array[Double]) -> BiophylobootstrapVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_bootstrap_vector_zero(dim : Int) -> BiophylobootstrapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylobootstrapVector::add(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobootstrapVector::sub(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobootstrapVector::scale(self : BiophylobootstrapVector, s : Double) -> BiophylobootstrapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylobootstrapVector::dot(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylobootstrapVector::norm(self : BiophylobootstrapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylobootstrapVector::normalize(self : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobootstrapVector::dist(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylobootstrapVector::to_string(self : BiophylobootstrapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobootstrapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_frame_make(size : Int) -> BiophylobootstrapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapFrame::len(self : BiophylobootstrapFrame) -> Int { self.size }

pub fn BiophylobootstrapFrame::get(self : BiophylobootstrapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapFrame::set(self : BiophylobootstrapFrame, i : Int, v : Double) -> BiophylobootstrapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapFrame::sum(self : BiophylobootstrapFrame) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapFrame::mean(self : BiophylobootstrapFrame) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapFrame::scale(self : BiophylobootstrapFrame, f : Double) -> BiophylobootstrapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapFrame::add(self : BiophylobootstrapFrame, other : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapFrame::copy(self : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapFrame::fill(self : BiophylobootstrapFrame, v : Double) -> BiophylobootstrapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapFrame::min(self : BiophylobootstrapFrame) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapFrame::max(self : BiophylobootstrapFrame) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapFrame::to_string(self : BiophylobootstrapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_table_make(size : Int) -> BiophylobootstrapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapTable::len(self : BiophylobootstrapTable) -> Int { self.size }

pub fn BiophylobootstrapTable::get(self : BiophylobootstrapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapTable::set(self : BiophylobootstrapTable, i : Int, v : Double) -> BiophylobootstrapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapTable::sum(self : BiophylobootstrapTable) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapTable::mean(self : BiophylobootstrapTable) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapTable::scale(self : BiophylobootstrapTable, f : Double) -> BiophylobootstrapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapTable::add(self : BiophylobootstrapTable, other : BiophylobootstrapTable) -> BiophylobootstrapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapTable::copy(self : BiophylobootstrapTable) -> BiophylobootstrapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapTable::fill(self : BiophylobootstrapTable, v : Double) -> BiophylobootstrapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapTable::min(self : BiophylobootstrapTable) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapTable::max(self : BiophylobootstrapTable) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapTable::to_string(self : BiophylobootstrapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_graphn_make(size : Int) -> BiophylobootstrapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapGraphN::len(self : BiophylobootstrapGraphN) -> Int { self.size }

pub fn BiophylobootstrapGraphN::get(self : BiophylobootstrapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapGraphN::set(self : BiophylobootstrapGraphN, i : Int, v : Double) -> BiophylobootstrapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapGraphN::sum(self : BiophylobootstrapGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapGraphN::mean(self : BiophylobootstrapGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapGraphN::scale(self : BiophylobootstrapGraphN, f : Double) -> BiophylobootstrapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapGraphN::add(self : BiophylobootstrapGraphN, other : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapGraphN::copy(self : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapGraphN::fill(self : BiophylobootstrapGraphN, v : Double) -> BiophylobootstrapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapGraphN::min(self : BiophylobootstrapGraphN) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapGraphN::max(self : BiophylobootstrapGraphN) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapGraphN::to_string(self : BiophylobootstrapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_node_make(size : Int) -> BiophylobootstrapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapNode::len(self : BiophylobootstrapNode) -> Int { self.size }

pub fn BiophylobootstrapNode::get(self : BiophylobootstrapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapNode::set(self : BiophylobootstrapNode, i : Int, v : Double) -> BiophylobootstrapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapNode::sum(self : BiophylobootstrapNode) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapNode::mean(self : BiophylobootstrapNode) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapNode::scale(self : BiophylobootstrapNode, f : Double) -> BiophylobootstrapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapNode::add(self : BiophylobootstrapNode, other : BiophylobootstrapNode) -> BiophylobootstrapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapNode::copy(self : BiophylobootstrapNode) -> BiophylobootstrapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapNode::fill(self : BiophylobootstrapNode, v : Double) -> BiophylobootstrapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapNode::min(self : BiophylobootstrapNode) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapNode::max(self : BiophylobootstrapNode) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapNode::to_string(self : BiophylobootstrapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_edge_make(size : Int) -> BiophylobootstrapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapEdge::len(self : BiophylobootstrapEdge) -> Int { self.size }

pub fn BiophylobootstrapEdge::get(self : BiophylobootstrapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapEdge::set(self : BiophylobootstrapEdge, i : Int, v : Double) -> BiophylobootstrapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapEdge::sum(self : BiophylobootstrapEdge) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapEdge::mean(self : BiophylobootstrapEdge) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapEdge::scale(self : BiophylobootstrapEdge, f : Double) -> BiophylobootstrapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapEdge::add(self : BiophylobootstrapEdge, other : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapEdge::copy(self : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapEdge::fill(self : BiophylobootstrapEdge, v : Double) -> BiophylobootstrapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapEdge::min(self : BiophylobootstrapEdge) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapEdge::max(self : BiophylobootstrapEdge) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapEdge::to_string(self : BiophylobootstrapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_path_make(size : Int) -> BiophylobootstrapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapPath::len(self : BiophylobootstrapPath) -> Int { self.size }

pub fn BiophylobootstrapPath::get(self : BiophylobootstrapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapPath::set(self : BiophylobootstrapPath, i : Int, v : Double) -> BiophylobootstrapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapPath::sum(self : BiophylobootstrapPath) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapPath::mean(self : BiophylobootstrapPath) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapPath::scale(self : BiophylobootstrapPath, f : Double) -> BiophylobootstrapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapPath::add(self : BiophylobootstrapPath, other : BiophylobootstrapPath) -> BiophylobootstrapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapPath::copy(self : BiophylobootstrapPath) -> BiophylobootstrapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapPath::fill(self : BiophylobootstrapPath, v : Double) -> BiophylobootstrapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapPath::min(self : BiophylobootstrapPath) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapPath::max(self : BiophylobootstrapPath) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapPath::to_string(self : BiophylobootstrapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cluster_make(size : Int) -> BiophylobootstrapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapCluster::len(self : BiophylobootstrapCluster) -> Int { self.size }

pub fn BiophylobootstrapCluster::get(self : BiophylobootstrapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapCluster::set(self : BiophylobootstrapCluster, i : Int, v : Double) -> BiophylobootstrapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCluster::sum(self : BiophylobootstrapCluster) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapCluster::mean(self : BiophylobootstrapCluster) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapCluster::scale(self : BiophylobootstrapCluster, f : Double) -> BiophylobootstrapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCluster::add(self : BiophylobootstrapCluster, other : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapCluster::copy(self : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCluster::fill(self : BiophylobootstrapCluster, v : Double) -> BiophylobootstrapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCluster::min(self : BiophylobootstrapCluster) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapCluster::max(self : BiophylobootstrapCluster) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapCluster::to_string(self : BiophylobootstrapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_model_make(size : Int) -> BiophylobootstrapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapModel::len(self : BiophylobootstrapModel) -> Int { self.size }

pub fn BiophylobootstrapModel::get(self : BiophylobootstrapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapModel::set(self : BiophylobootstrapModel, i : Int, v : Double) -> BiophylobootstrapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapModel::sum(self : BiophylobootstrapModel) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapModel::mean(self : BiophylobootstrapModel) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapModel::scale(self : BiophylobootstrapModel, f : Double) -> BiophylobootstrapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapModel::add(self : BiophylobootstrapModel, other : BiophylobootstrapModel) -> BiophylobootstrapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapModel::copy(self : BiophylobootstrapModel) -> BiophylobootstrapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapModel::fill(self : BiophylobootstrapModel, v : Double) -> BiophylobootstrapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapModel::min(self : BiophylobootstrapModel) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapModel::max(self : BiophylobootstrapModel) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapModel::to_string(self : BiophylobootstrapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_layer_make(size : Int) -> BiophylobootstrapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapLayer::len(self : BiophylobootstrapLayer) -> Int { self.size }

pub fn BiophylobootstrapLayer::get(self : BiophylobootstrapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapLayer::set(self : BiophylobootstrapLayer, i : Int, v : Double) -> BiophylobootstrapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapLayer::sum(self : BiophylobootstrapLayer) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapLayer::mean(self : BiophylobootstrapLayer) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapLayer::scale(self : BiophylobootstrapLayer, f : Double) -> BiophylobootstrapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapLayer::add(self : BiophylobootstrapLayer, other : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapLayer::copy(self : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapLayer::fill(self : BiophylobootstrapLayer, v : Double) -> BiophylobootstrapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapLayer::min(self : BiophylobootstrapLayer) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapLayer::max(self : BiophylobootstrapLayer) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapLayer::to_string(self : BiophylobootstrapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_buffer_make(size : Int) -> BiophylobootstrapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapBuffer::len(self : BiophylobootstrapBuffer) -> Int { self.size }

pub fn BiophylobootstrapBuffer::get(self : BiophylobootstrapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapBuffer::set(self : BiophylobootstrapBuffer, i : Int, v : Double) -> BiophylobootstrapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapBuffer::sum(self : BiophylobootstrapBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapBuffer::mean(self : BiophylobootstrapBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapBuffer::scale(self : BiophylobootstrapBuffer, f : Double) -> BiophylobootstrapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapBuffer::add(self : BiophylobootstrapBuffer, other : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapBuffer::copy(self : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapBuffer::fill(self : BiophylobootstrapBuffer, v : Double) -> BiophylobootstrapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapBuffer::min(self : BiophylobootstrapBuffer) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapBuffer::max(self : BiophylobootstrapBuffer) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapBuffer::to_string(self : BiophylobootstrapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cursor_make(size : Int) -> BiophylobootstrapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapCursor::len(self : BiophylobootstrapCursor) -> Int { self.size }

pub fn BiophylobootstrapCursor::get(self : BiophylobootstrapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapCursor::set(self : BiophylobootstrapCursor, i : Int, v : Double) -> BiophylobootstrapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCursor::sum(self : BiophylobootstrapCursor) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapCursor::mean(self : BiophylobootstrapCursor) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapCursor::scale(self : BiophylobootstrapCursor, f : Double) -> BiophylobootstrapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCursor::add(self : BiophylobootstrapCursor, other : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapCursor::copy(self : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCursor::fill(self : BiophylobootstrapCursor, v : Double) -> BiophylobootstrapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapCursor::min(self : BiophylobootstrapCursor) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapCursor::max(self : BiophylobootstrapCursor) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapCursor::to_string(self : BiophylobootstrapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_view_make(size : Int) -> BiophylobootstrapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapView::len(self : BiophylobootstrapView) -> Int { self.size }

pub fn BiophylobootstrapView::get(self : BiophylobootstrapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapView::set(self : BiophylobootstrapView, i : Int, v : Double) -> BiophylobootstrapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapView::sum(self : BiophylobootstrapView) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapView::mean(self : BiophylobootstrapView) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapView::scale(self : BiophylobootstrapView, f : Double) -> BiophylobootstrapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapView::add(self : BiophylobootstrapView, other : BiophylobootstrapView) -> BiophylobootstrapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapView::copy(self : BiophylobootstrapView) -> BiophylobootstrapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapView::fill(self : BiophylobootstrapView, v : Double) -> BiophylobootstrapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapView::min(self : BiophylobootstrapView) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapView::max(self : BiophylobootstrapView) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapView::to_string(self : BiophylobootstrapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_range_make(size : Int) -> BiophylobootstrapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapRange::len(self : BiophylobootstrapRange) -> Int { self.size }

pub fn BiophylobootstrapRange::get(self : BiophylobootstrapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapRange::set(self : BiophylobootstrapRange, i : Int, v : Double) -> BiophylobootstrapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapRange::sum(self : BiophylobootstrapRange) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapRange::mean(self : BiophylobootstrapRange) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapRange::scale(self : BiophylobootstrapRange, f : Double) -> BiophylobootstrapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapRange::add(self : BiophylobootstrapRange, other : BiophylobootstrapRange) -> BiophylobootstrapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapRange::copy(self : BiophylobootstrapRange) -> BiophylobootstrapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapRange::fill(self : BiophylobootstrapRange, v : Double) -> BiophylobootstrapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapRange::min(self : BiophylobootstrapRange) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapRange::max(self : BiophylobootstrapRange) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapRange::to_string(self : BiophylobootstrapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_slice_make(size : Int) -> BiophylobootstrapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobootstrapSlice::len(self : BiophylobootstrapSlice) -> Int { self.size }

pub fn BiophylobootstrapSlice::get(self : BiophylobootstrapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobootstrapSlice::set(self : BiophylobootstrapSlice, i : Int, v : Double) -> BiophylobootstrapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapSlice::sum(self : BiophylobootstrapSlice) -> Double { @_common.sum(self.data) }

pub fn BiophylobootstrapSlice::mean(self : BiophylobootstrapSlice) -> Double { @_common.mean(self.data) }

pub fn BiophylobootstrapSlice::scale(self : BiophylobootstrapSlice, f : Double) -> BiophylobootstrapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapSlice::add(self : BiophylobootstrapSlice, other : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobootstrapSlice::copy(self : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapSlice::fill(self : BiophylobootstrapSlice, v : Double) -> BiophylobootstrapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobootstrapSlice::min(self : BiophylobootstrapSlice) -> Double { @_common.min(self.data) }

pub fn BiophylobootstrapSlice::max(self : BiophylobootstrapSlice) -> Double { @_common.max(self.data) }

pub fn BiophylobootstrapSlice::to_string(self : BiophylobootstrapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

