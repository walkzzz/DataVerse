///===
/// extcore/bio_phylo_reconcile

pub(all) struct BiophyloreconcilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_reconcile_make_point(x : Double, y : Double) -> BiophyloreconcilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_reconcile_make_point3(x : Double, y : Double, z : Double) -> BiophyloreconcilePoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloreconcilePoint::x(self : BiophyloreconcilePoint) -> Double { self.x }

pub fn BiophyloreconcilePoint::y(self : BiophyloreconcilePoint) -> Double { self.y }

pub fn BiophyloreconcilePoint::z(self : BiophyloreconcilePoint) -> Double { self.z }

pub fn BiophyloreconcilePoint::label(self : BiophyloreconcilePoint) -> Int { self.label }

pub fn BiophyloreconcilePoint::dist(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloreconcilePoint::add(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloreconcilePoint::sub(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloreconcilePoint::scale(self : BiophyloreconcilePoint, s : Double) -> BiophyloreconcilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloreconcilePoint::dot(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloreconcilePoint::cross(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloreconcilePoint::norm(self : BiophyloreconcilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloreconcilePoint::normalize(self : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloreconcilePoint::negate(self : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloreconcilePoint::mid(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloreconcilePoint::lerp(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint, t : Double) -> BiophyloreconcilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloreconcilePoint::to_string(self : BiophyloreconcilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloreconcileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_reconcile_make_series(vals : Array[Double], name : String) -> BiophyloreconcileSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloreconcileSeries::len(self : BiophyloreconcileSeries) -> Int { self.vals.length() }

pub fn BiophyloreconcileSeries::sum(self : BiophyloreconcileSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloreconcileSeries::mean(self : BiophyloreconcileSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloreconcileSeries::min(self : BiophyloreconcileSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloreconcileSeries::max(self : BiophyloreconcileSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloreconcileSeries::range(self : BiophyloreconcileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloreconcileSeries::variance(self : BiophyloreconcileSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloreconcileSeries::std(self : BiophyloreconcileSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloreconcileSeries::median(self : BiophyloreconcileSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloreconcileSeries::scale(self : BiophyloreconcileSeries, f : Double) -> BiophyloreconcileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::add(self : BiophyloreconcileSeries, other : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::sub(self : BiophyloreconcileSeries, other : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::normalize(self : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloreconcileSeries::cumsum(self : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloreconcileSeries::to_string(self : BiophyloreconcileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloreconcileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_reconcile_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloreconcileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_reconcile_matrix_identity(n : Int) -> BiophyloreconcileMatrix {
  let m = bio_phylo_reconcile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloreconcileMatrix::get(self : BiophyloreconcileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloreconcileMatrix::transpose(self : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloreconcileMatrix::add(self : BiophyloreconcileMatrix, other : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_reconcile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloreconcileMatrix::scale(self : BiophyloreconcileMatrix, s : Double) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloreconcileMatrix::multiply(self : BiophyloreconcileMatrix, other : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if self.cols != other.rows { return bio_phylo_reconcile_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_reconcile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloreconcileMatrix::trace(self : BiophyloreconcileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloreconcileMatrix::det(self : BiophyloreconcileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloreconcileMatrix::norm(self : BiophyloreconcileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloreconcileMatrix::to_string(self : BiophyloreconcileMatrix) -> String {
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

pub(all) struct BiophyloreconcileVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_reconcile_make_vector(comps : Array[Double]) -> BiophyloreconcileVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_reconcile_vector_zero(dim : Int) -> BiophyloreconcileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloreconcileVector::add(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloreconcileVector::sub(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloreconcileVector::scale(self : BiophyloreconcileVector, s : Double) -> BiophyloreconcileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloreconcileVector::dot(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloreconcileVector::norm(self : BiophyloreconcileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloreconcileVector::normalize(self : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloreconcileVector::dist(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloreconcileVector::to_string(self : BiophyloreconcileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloreconcileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_frame_make(size : Int) -> BiophyloreconcileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileFrame::len(self : BiophyloreconcileFrame) -> Int { self.size }

pub fn BiophyloreconcileFrame::get(self : BiophyloreconcileFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileFrame::set(self : BiophyloreconcileFrame, i : Int, v : Double) -> BiophyloreconcileFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileFrame::sum(self : BiophyloreconcileFrame) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileFrame::mean(self : BiophyloreconcileFrame) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileFrame::scale(self : BiophyloreconcileFrame, f : Double) -> BiophyloreconcileFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileFrame::add(self : BiophyloreconcileFrame, other : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileFrame::copy(self : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileFrame::fill(self : BiophyloreconcileFrame, v : Double) -> BiophyloreconcileFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileFrame::min(self : BiophyloreconcileFrame) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileFrame::max(self : BiophyloreconcileFrame) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileFrame::to_string(self : BiophyloreconcileFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_table_make(size : Int) -> BiophyloreconcileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileTable::len(self : BiophyloreconcileTable) -> Int { self.size }

pub fn BiophyloreconcileTable::get(self : BiophyloreconcileTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileTable::set(self : BiophyloreconcileTable, i : Int, v : Double) -> BiophyloreconcileTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileTable::sum(self : BiophyloreconcileTable) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileTable::mean(self : BiophyloreconcileTable) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileTable::scale(self : BiophyloreconcileTable, f : Double) -> BiophyloreconcileTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileTable::add(self : BiophyloreconcileTable, other : BiophyloreconcileTable) -> BiophyloreconcileTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileTable::copy(self : BiophyloreconcileTable) -> BiophyloreconcileTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileTable::fill(self : BiophyloreconcileTable, v : Double) -> BiophyloreconcileTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileTable::min(self : BiophyloreconcileTable) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileTable::max(self : BiophyloreconcileTable) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileTable::to_string(self : BiophyloreconcileTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_graphn_make(size : Int) -> BiophyloreconcileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileGraphN::len(self : BiophyloreconcileGraphN) -> Int { self.size }

pub fn BiophyloreconcileGraphN::get(self : BiophyloreconcileGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileGraphN::set(self : BiophyloreconcileGraphN, i : Int, v : Double) -> BiophyloreconcileGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileGraphN::sum(self : BiophyloreconcileGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileGraphN::mean(self : BiophyloreconcileGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileGraphN::scale(self : BiophyloreconcileGraphN, f : Double) -> BiophyloreconcileGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileGraphN::add(self : BiophyloreconcileGraphN, other : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileGraphN::copy(self : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileGraphN::fill(self : BiophyloreconcileGraphN, v : Double) -> BiophyloreconcileGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileGraphN::min(self : BiophyloreconcileGraphN) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileGraphN::max(self : BiophyloreconcileGraphN) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileGraphN::to_string(self : BiophyloreconcileGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_node_make(size : Int) -> BiophyloreconcileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileNode::len(self : BiophyloreconcileNode) -> Int { self.size }

pub fn BiophyloreconcileNode::get(self : BiophyloreconcileNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileNode::set(self : BiophyloreconcileNode, i : Int, v : Double) -> BiophyloreconcileNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileNode::sum(self : BiophyloreconcileNode) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileNode::mean(self : BiophyloreconcileNode) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileNode::scale(self : BiophyloreconcileNode, f : Double) -> BiophyloreconcileNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileNode::add(self : BiophyloreconcileNode, other : BiophyloreconcileNode) -> BiophyloreconcileNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileNode::copy(self : BiophyloreconcileNode) -> BiophyloreconcileNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileNode::fill(self : BiophyloreconcileNode, v : Double) -> BiophyloreconcileNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileNode::min(self : BiophyloreconcileNode) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileNode::max(self : BiophyloreconcileNode) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileNode::to_string(self : BiophyloreconcileNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_edge_make(size : Int) -> BiophyloreconcileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileEdge::len(self : BiophyloreconcileEdge) -> Int { self.size }

pub fn BiophyloreconcileEdge::get(self : BiophyloreconcileEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileEdge::set(self : BiophyloreconcileEdge, i : Int, v : Double) -> BiophyloreconcileEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileEdge::sum(self : BiophyloreconcileEdge) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileEdge::mean(self : BiophyloreconcileEdge) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileEdge::scale(self : BiophyloreconcileEdge, f : Double) -> BiophyloreconcileEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileEdge::add(self : BiophyloreconcileEdge, other : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileEdge::copy(self : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileEdge::fill(self : BiophyloreconcileEdge, v : Double) -> BiophyloreconcileEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileEdge::min(self : BiophyloreconcileEdge) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileEdge::max(self : BiophyloreconcileEdge) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileEdge::to_string(self : BiophyloreconcileEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_path_make(size : Int) -> BiophyloreconcilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcilePath::len(self : BiophyloreconcilePath) -> Int { self.size }

pub fn BiophyloreconcilePath::get(self : BiophyloreconcilePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcilePath::set(self : BiophyloreconcilePath, i : Int, v : Double) -> BiophyloreconcilePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcilePath::sum(self : BiophyloreconcilePath) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcilePath::mean(self : BiophyloreconcilePath) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcilePath::scale(self : BiophyloreconcilePath, f : Double) -> BiophyloreconcilePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcilePath::add(self : BiophyloreconcilePath, other : BiophyloreconcilePath) -> BiophyloreconcilePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcilePath::copy(self : BiophyloreconcilePath) -> BiophyloreconcilePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcilePath::fill(self : BiophyloreconcilePath, v : Double) -> BiophyloreconcilePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcilePath::min(self : BiophyloreconcilePath) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcilePath::max(self : BiophyloreconcilePath) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcilePath::to_string(self : BiophyloreconcilePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cluster_make(size : Int) -> BiophyloreconcileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileCluster::len(self : BiophyloreconcileCluster) -> Int { self.size }

pub fn BiophyloreconcileCluster::get(self : BiophyloreconcileCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileCluster::set(self : BiophyloreconcileCluster, i : Int, v : Double) -> BiophyloreconcileCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCluster::sum(self : BiophyloreconcileCluster) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileCluster::mean(self : BiophyloreconcileCluster) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileCluster::scale(self : BiophyloreconcileCluster, f : Double) -> BiophyloreconcileCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCluster::add(self : BiophyloreconcileCluster, other : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileCluster::copy(self : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCluster::fill(self : BiophyloreconcileCluster, v : Double) -> BiophyloreconcileCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCluster::min(self : BiophyloreconcileCluster) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileCluster::max(self : BiophyloreconcileCluster) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileCluster::to_string(self : BiophyloreconcileCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_model_make(size : Int) -> BiophyloreconcileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileModel::len(self : BiophyloreconcileModel) -> Int { self.size }

pub fn BiophyloreconcileModel::get(self : BiophyloreconcileModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileModel::set(self : BiophyloreconcileModel, i : Int, v : Double) -> BiophyloreconcileModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileModel::sum(self : BiophyloreconcileModel) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileModel::mean(self : BiophyloreconcileModel) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileModel::scale(self : BiophyloreconcileModel, f : Double) -> BiophyloreconcileModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileModel::add(self : BiophyloreconcileModel, other : BiophyloreconcileModel) -> BiophyloreconcileModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileModel::copy(self : BiophyloreconcileModel) -> BiophyloreconcileModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileModel::fill(self : BiophyloreconcileModel, v : Double) -> BiophyloreconcileModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileModel::min(self : BiophyloreconcileModel) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileModel::max(self : BiophyloreconcileModel) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileModel::to_string(self : BiophyloreconcileModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_layer_make(size : Int) -> BiophyloreconcileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileLayer::len(self : BiophyloreconcileLayer) -> Int { self.size }

pub fn BiophyloreconcileLayer::get(self : BiophyloreconcileLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileLayer::set(self : BiophyloreconcileLayer, i : Int, v : Double) -> BiophyloreconcileLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileLayer::sum(self : BiophyloreconcileLayer) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileLayer::mean(self : BiophyloreconcileLayer) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileLayer::scale(self : BiophyloreconcileLayer, f : Double) -> BiophyloreconcileLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileLayer::add(self : BiophyloreconcileLayer, other : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileLayer::copy(self : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileLayer::fill(self : BiophyloreconcileLayer, v : Double) -> BiophyloreconcileLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileLayer::min(self : BiophyloreconcileLayer) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileLayer::max(self : BiophyloreconcileLayer) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileLayer::to_string(self : BiophyloreconcileLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_buffer_make(size : Int) -> BiophyloreconcileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileBuffer::len(self : BiophyloreconcileBuffer) -> Int { self.size }

pub fn BiophyloreconcileBuffer::get(self : BiophyloreconcileBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileBuffer::set(self : BiophyloreconcileBuffer, i : Int, v : Double) -> BiophyloreconcileBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileBuffer::sum(self : BiophyloreconcileBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileBuffer::mean(self : BiophyloreconcileBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileBuffer::scale(self : BiophyloreconcileBuffer, f : Double) -> BiophyloreconcileBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileBuffer::add(self : BiophyloreconcileBuffer, other : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileBuffer::copy(self : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileBuffer::fill(self : BiophyloreconcileBuffer, v : Double) -> BiophyloreconcileBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileBuffer::min(self : BiophyloreconcileBuffer) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileBuffer::max(self : BiophyloreconcileBuffer) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileBuffer::to_string(self : BiophyloreconcileBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cursor_make(size : Int) -> BiophyloreconcileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileCursor::len(self : BiophyloreconcileCursor) -> Int { self.size }

pub fn BiophyloreconcileCursor::get(self : BiophyloreconcileCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileCursor::set(self : BiophyloreconcileCursor, i : Int, v : Double) -> BiophyloreconcileCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCursor::sum(self : BiophyloreconcileCursor) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileCursor::mean(self : BiophyloreconcileCursor) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileCursor::scale(self : BiophyloreconcileCursor, f : Double) -> BiophyloreconcileCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCursor::add(self : BiophyloreconcileCursor, other : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileCursor::copy(self : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCursor::fill(self : BiophyloreconcileCursor, v : Double) -> BiophyloreconcileCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileCursor::min(self : BiophyloreconcileCursor) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileCursor::max(self : BiophyloreconcileCursor) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileCursor::to_string(self : BiophyloreconcileCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_view_make(size : Int) -> BiophyloreconcileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileView::len(self : BiophyloreconcileView) -> Int { self.size }

pub fn BiophyloreconcileView::get(self : BiophyloreconcileView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileView::set(self : BiophyloreconcileView, i : Int, v : Double) -> BiophyloreconcileView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileView::sum(self : BiophyloreconcileView) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileView::mean(self : BiophyloreconcileView) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileView::scale(self : BiophyloreconcileView, f : Double) -> BiophyloreconcileView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileView::add(self : BiophyloreconcileView, other : BiophyloreconcileView) -> BiophyloreconcileView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileView::copy(self : BiophyloreconcileView) -> BiophyloreconcileView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileView::fill(self : BiophyloreconcileView, v : Double) -> BiophyloreconcileView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileView::min(self : BiophyloreconcileView) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileView::max(self : BiophyloreconcileView) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileView::to_string(self : BiophyloreconcileView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_range_make(size : Int) -> BiophyloreconcileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileRange::len(self : BiophyloreconcileRange) -> Int { self.size }

pub fn BiophyloreconcileRange::get(self : BiophyloreconcileRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileRange::set(self : BiophyloreconcileRange, i : Int, v : Double) -> BiophyloreconcileRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileRange::sum(self : BiophyloreconcileRange) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileRange::mean(self : BiophyloreconcileRange) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileRange::scale(self : BiophyloreconcileRange, f : Double) -> BiophyloreconcileRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileRange::add(self : BiophyloreconcileRange, other : BiophyloreconcileRange) -> BiophyloreconcileRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileRange::copy(self : BiophyloreconcileRange) -> BiophyloreconcileRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileRange::fill(self : BiophyloreconcileRange, v : Double) -> BiophyloreconcileRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileRange::min(self : BiophyloreconcileRange) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileRange::max(self : BiophyloreconcileRange) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileRange::to_string(self : BiophyloreconcileRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_slice_make(size : Int) -> BiophyloreconcileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloreconcileSlice::len(self : BiophyloreconcileSlice) -> Int { self.size }

pub fn BiophyloreconcileSlice::get(self : BiophyloreconcileSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloreconcileSlice::set(self : BiophyloreconcileSlice, i : Int, v : Double) -> BiophyloreconcileSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileSlice::sum(self : BiophyloreconcileSlice) -> Double { @_common.sum(self.data) }

pub fn BiophyloreconcileSlice::mean(self : BiophyloreconcileSlice) -> Double { @_common.mean(self.data) }

pub fn BiophyloreconcileSlice::scale(self : BiophyloreconcileSlice, f : Double) -> BiophyloreconcileSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileSlice::add(self : BiophyloreconcileSlice, other : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloreconcileSlice::copy(self : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileSlice::fill(self : BiophyloreconcileSlice, v : Double) -> BiophyloreconcileSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloreconcileSlice::min(self : BiophyloreconcileSlice) -> Double { @_common.min(self.data) }

pub fn BiophyloreconcileSlice::max(self : BiophyloreconcileSlice) -> Double { @_common.max(self.data) }

pub fn BiophyloreconcileSlice::to_string(self : BiophyloreconcileSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

